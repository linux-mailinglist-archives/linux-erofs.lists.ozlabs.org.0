Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC701F0AA0
	for <lists+linux-erofs@lfdr.de>; Sun,  7 Jun 2020 11:25:57 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49frbQ4j0bzDqc6
	for <lists+linux-erofs@lfdr.de>; Sun,  7 Jun 2020 19:25:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1591521954;
	bh=n6ewM5oLpPMbfDIMiMq91kNAjdXVaINxwNMvg/Wz/o8=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=XEvXjGQzw7bVQTyzEPS6mG+pL/ee3EjdBE7qW/BU3A7PLYH6Sl5tDP03+Q74R1AW1
	 WQVwGK+i3X81+/SJlrTx9rJOzxjMwWNkyRy0WEiPaMPXz7ZyvZaitYrG44C02tV5qD
	 Vskigjrb6YhOaMMPFX+ZfV5RjrTASv00HfMeU062MBAJhMOmjQLfVuwA75OX+SgSte
	 IpQbefi9bNJvCDP0hD3dyBiH6nBIsqLtWQMxgz6wAcIfNfOpcwDk9pdKBQ/pSXKYjI
	 X6OZfLtc3dSuL5+AYnIqlG/jyG/SshJZZ/7R/xRLcC7vrcNTdKxtPw37hNzenT5Dyu
	 J+Eooryof5vJA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.27;
 helo=out30-27.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=lYFVO9u2; dkim-atps=neutral
Received: from out30-27.freemail.mail.aliyun.com
 (out30-27.freemail.mail.aliyun.com [115.124.30.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49frb56SVRzDqVK
 for <linux-erofs@lists.ozlabs.org>; Sun,  7 Jun 2020 19:25:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1591521915; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=Zv/kkvueaDdACD0RLqiYUxJP1BdXKbqaIvC9dFiZnLU=;
 b=lYFVO9u25SL/tpxFBqkP/vStki+ZMlKf0xZ4uk7uvddV0QjyrAHSQs+ZLWgDtTpCuIgbHZ1yoXNkZtIPJcIlgoaYkV2cfMiQd0NxbeCe75jTL8g3BGGdgaRYrWCK+1610jQnAtIMhzZ5TW2sYTC+VvISsfHkfSqh48M5lDfZufU=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07357798|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.00472508-0.000434941-0.99484;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e01422; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=3; RT=3; SR=0; TI=SMTPD_---0U-pH8Vt_1591521913; 
Received: from 192.168.3.5(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0U-pH8Vt_1591521913) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 07 Jun 2020 17:25:13 +0800
Subject: Re: [PATCH v2] erofs-utils: support selinux file contexts
To: Gao Xiang <hsiangkao@redhat.com>, linux-erofs@lists.ozlabs.org
References: <20200530161127.16750-1-hsiangkao@redhat.com>
 <20200606081752.27848-1-hsiangkao@redhat.com>
Message-ID: <0095f9b2-e999-e047-c789-b8ef6c1cea81@aliyun.com>
Date: Sun, 7 Jun 2020 17:25:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200606081752.27848-1-hsiangkao@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Li GuiFu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Li GuiFu <bluce.lee@aliyun.com>
Cc: Shung Wang <waterbird0806@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

It cacuses one build error in my Ubuntu 18.04.1 LTS
and it seems selinux static lib link cause it
libtool: link: gcc -Wall -Werror -I../include -g -O2 -static -o
mkfs.erofs mkfs_erofs-main.o  ../lib/.libs/liberofs.a
-L/home/liguifu/codes/lz4 -luuid -lselinux -llz4
/usr/lib/gcc/x86_64-linux-gnu/8/../../../x86_64-linux-gnu/libselinux.a(seusers.o):
In function `getseuserbyname':
(.text+0x5e9): warning: Using 'getgrouplist' in statically linked
applications requires at runtime the shared libraries from the glibc
version used for linking
(.text+0x570): warning: Using 'getgrnam_r' in statically linked
applications requires at runtime the shared libraries from the glibc
version used for linking
(.text+0x9e): warning: Using 'getpwnam_r' in statically linked
applications requires at runtime the shared libraries from the glibc
version used for linking
/usr/lib/gcc/x86_64-linux-gnu/8/../../../x86_64-linux-gnu/libselinux.a(regex.o):
In function `regex_writef':
(.text+0x73): undefined reference to `pcre_fullinfo'
(.text+0xe7): undefined reference to `pcre_fullinfo'
/usr/lib/gcc/x86_64-linux-gnu/8/../../../x86_64-linux-gnu/libselinux.a(regex.o):
In function `regex_data_free':
(.text+0x1da): undefined reference to `pcre_free'
(.text+0x1e8): undefined reference to `pcre_free_study'
/usr/lib/gcc/x86_64-linux-gnu/8/../../../x86_64-linux-gnu/libselinux.a(regex.o):
In function `regex_prepare_data':
(.text+0x248): undefined reference to `pcre_compile'
(.text+0x269): undefined reference to `pcre_study'
/usr/lib/gcc/x86_64-linux-gnu/8/../../../x86_64-linux-gnu/libselinux.a(regex.o):
In function `regex_load_mmap':
(.text+0x36a): undefined reference to `pcre_fullinfo'
(.text+0x3df): undefined reference to `pcre_fullinfo'
/usr/lib/gcc/x86_64-linux-gnu/8/../../../x86_64-linux-gnu/libselinux.a(regex.o):
In function `regex_match':
(.text+0x48b): undefined reference to `pcre_exec'
/usr/lib/gcc/x86_64-linux-gnu/8/../../../x86_64-linux-gnu/libselinux.a(regex.o):
In function `regex_cmp':
(.text+0x4ed): undefined reference to `pcre_fullinfo'
(.text+0x506): undefined reference to `pcre_fullinfo'
/usr/lib/gcc/x86_64-linux-gnu/8/../../../x86_64-linux-gnu/libselinux.a(regex.o):
In function `regex_version':
(.text+0x11): undefined reference to `pcre_version'
/usr/lib/gcc/x86_64-linux-gnu/8/../../../x86_64-linux-gnu/libselinux.a(load_policy.o):
In function `selinux_mkload_policy':
(.text+0x134): undefined reference to `sepol_policy_kern_vers_max'
(.text+0x13d): undefined reference to `sepol_policy_kern_vers_min'
(.text+0x2f3): undefined reference to `sepol_policy_kern_vers_max'
(.text+0x2fc): undefined reference to `sepol_policy_kern_vers_min'
(.text+0x331): undefined reference to `sepol_policy_kern_vers_max'
(.text+0x33a): undefined reference to `sepol_policy_kern_vers_min'
(.text+0x3b2): undefined reference to `sepol_policy_file_create'
(.text+0x3c4): undefined reference to `sepol_policydb_create'
(.text+0x3e0): undefined reference to `sepol_policy_file_set_mem'
(.text+0x3ef): undefined reference to `sepol_policydb_read'
(.text+0x405): undefined reference to `sepol_policydb_set_vers'
(.text+0x41f): undefined reference to `sepol_policydb_to_image'
(.text+0x451): undefined reference to `sepol_policy_file_free'
(.text+0x45b): undefined reference to `sepol_policydb_free'
(.text+0x4a0): undefined reference to `sepol_policy_kern_vers_max'
(.text+0x4a9): undefined reference to `sepol_policy_kern_vers_min'
(.text+0x4bf): undefined reference to `sepol_policy_file_free'
(.text+0x4c9): undefined reference to `sepol_policydb_free'
(.text+0x5bf): undefined reference to `sepol_policy_file_free'
(.text+0x5d3): undefined reference to `sepol_policy_file_free'
(.text+0x5dd): undefined reference to `sepol_policydb_free'
(.text+0x6d9): undefined reference to `sepol_genbools_array'
(.text+0x73a): undefined reference to `sepol_genusers'
(.text+0x76e): undefined reference to `sepol_genbools'
collect2: error: ld returned 1 exit status
Makefile:398: recipe for target 'mkfs.erofs' failed

On 2020/6/6 16:17, Gao Xiang wrote:
> Add --file-contexts flag that allows passing a selinux
> file_context file to setup file selabels.
> 
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> ---
> changes since v1:
>  fix selinux error handing and wrap up selabel
>  open pointed out by Guifu;
> 
>  configure.ac           |  27 +++++++++
>  include/erofs/config.h |  21 +++++++
>  include/erofs/xattr.h  |   3 +-
>  lib/config.c           |  42 +++++++++++++
>  lib/exclude.c          |  12 +---
>  lib/inode.c            |   3 +-
>  lib/xattr.c            | 130 ++++++++++++++++++++++++++++++++---------
>  man/mkfs.erofs.1       |   3 +
>  mkfs/Makefile.am       |   4 +-
>  mkfs/main.c            |  15 ++++-
>  10 files changed, 217 insertions(+), 43 deletions(-)
> 
