#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;
use WWW::Mechanize::Firefox;

$|++;
my $m = WWW::Mechanize::Firefox->new();

my $print_ip = '';
my $email_suffix = '';  # 125.com etc...
$m->get( sprintf 'http://%s/web/guest/en/websys/webArch/authForm.cgi', $print_ip );

$m->form_name('form1');
$m->field( userid_work => 'admin' );  #默认用户是 admin
$m->click_button( value => 'Login' ); # 默认密码是空, 所以不用改

print "准备点击: Addres Book\n";
$m->selector( '#ADRS_MENU', single => 1 )->click;
print "已点击: Addres Book\n";

print "准备点击: Add User\n";
sleep(5);
my @items = $m->selector('html body table tbody tr td table tbody tr td div.commandLabel a.commandLabel');    #, single => 1 )->click;
my $item  = $items[3];
$item->click;
print "已点击: Add User\n";

my $em = { A => 2, B => 2, C => 3, D => 3, E => 4, F => 4, G => 5, H => 5, I => 6, J => 6, K => 6, L => 7, M => 7, N => 7, O => 8, P => 8, Q => 8, R => 9, S => 9, T => 9, U => 10, V => 10, W => 10, X => 11, Y => 11, Z => 11, }; 

while ( my $row = <DATA> ) {
    my $name = ( split /\s+/, $row )[0];
    sleep(6);
    print "处理: $name ";

    # 设置主窗口
    $m->form_name('mainForm');
    $m->field( entryNameIn        => $name );
    $m->field( mailAddressIn      => sprintf '%s@%s', $name, $email_suffix );
    $m->field( entryDisplayNameIn => $name );
   
    # 下拉列表
    my @indexs = $m->selector( 'select[name="entryTagInfoIn"]'); #, single => 1 );
    my $index = shift @indexs;
    $m->highlight_node( $index );
    $index->__setAttr( 'value', $em->{uc( substr $name, 0, 1) }); 
    my @buttons = $m->selector('a.defaultTableCommandButton');
    my $btn     = $buttons[1];
    $btn->click;
    print " 完成\n";
}

__DATA__
用户名 
