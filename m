Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A404D4457
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Mar 2022 11:16:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KDlMQ3DLPz306h
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Mar 2022 21:16:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Oj3mFFnS;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::631;
 helo=mail-ej1-x631.google.com; envelope-from=mudongliangabcd@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=Oj3mFFnS; dkim-atps=neutral
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KDlMH11yFz2xVb
 for <linux-erofs@lists.ozlabs.org>; Thu, 10 Mar 2022 21:15:53 +1100 (AEDT)
Received: by mail-ej1-x631.google.com with SMTP id dr20so10889985ejc.6
 for <linux-erofs@lists.ozlabs.org>; Thu, 10 Mar 2022 02:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=oxPqKGws/pEhXi0imAy1z5DR5Nzp9pa9kHPDnWv13x4=;
 b=Oj3mFFnSozPm8NzH9g0tnCwp7AmtoNcJ/2uN4xzFFWd+Qkjx2vlAtBrVFsYo+fSVGw
 TtvTtMEqb5S/uUxl926e7ytdfjgqYewXVBKhbjcQPC47qoejVqJrgYbyel6gwUvyiDpX
 mOg3Ji5Ft4B0lr30Mdr5bdhbMSexv06213IzsV0dOw0JZ6+TBz8CJC74QH2hylIIvF7f
 HiKyFgL6HEZmrsaxO3yeB7Oa0VN4EeXrFIPWFZ9MhSDHxun9fPvjXA2zDkBo3sqJqPZg
 AWwO9PQTTqgZ5TbBzSBSg16mznHRksixbj9VFlwnneWPYxLdmJmZVMuBmZ6z17dRo8tP
 54GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=oxPqKGws/pEhXi0imAy1z5DR5Nzp9pa9kHPDnWv13x4=;
 b=V3wzI9xjumfHZU2zO6POHWQnSPWYX3/QpmaLmDIAM0Xf6IiHaTrejmIsBm6TW7Rdx+
 dosFnfKVggn52gvVZFKRIKvLUENKiqAtAPzSw/j3XoB+/eWjmy6Nj4Sy57HqY8MIsIrx
 QF/VHjAB4SxXesq/jPobhBN1+vZWSHfoejQ2USF5bGfM8MHlXEX90RG6WhDiLp0XMN7L
 J+tgyVdikOvuYqiNT/H3rC4jyRHd2fXkmNShsE9y1jYlz1JgrfdZvjmaHroHR7aBZ4dG
 ADSSCxDjA5Ihh8lxRQx8vZ02DDvTr7SiJikB4Orj3dSbNrytY48fhWPXXSN8WfMupbtp
 Kg2w==
X-Gm-Message-State: AOAM533ZYl2wr4xfYXYL+MzUWyCYpUkKM148dQD6PGu2YcFd4sA983yz
 8tuLpfRRkTgA1H4wL2dyC9xHupGvFdLPu2af6B4=
X-Google-Smtp-Source: ABdhPJyeCqVSY3RsBw7Oi01mN0MFI49UrVGy6Mhhu6g9no5cgDQ3r81zYFcUq4fj2iea7mJ1TJAcerlwqRRAS5Uv7BU=
X-Received: by 2002:a17:906:1be1:b0:6ce:b0a8:17d with SMTP id
 t1-20020a1709061be100b006ceb0a8017dmr3418109ejg.413.1646907346364; Thu, 10
 Mar 2022 02:15:46 -0800 (PST)
MIME-Version: 1.0
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Thu, 10 Mar 2022 18:15:20 +0800
Message-ID: <CAD-N9QXNx=p3-QoWzk6pCznF32CZy8kM3vvo8mamfZZ9CpUKdw@mail.gmail.com>
Subject: How to fix the bug in "WARNING: kobject bug in
 erofs_unregister_sysfs"?
To: xiang@kernel.org, Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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
Cc: syzbot+045796dbe294d53147e6@syzkaller.appspotmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi kernel developers,

I am writing to kindly ask for some suggestions on fixing "WARNING:
kobject bug in erofs_unregister_sysfs".

The underlying issue is in the following,

erofs_fc_get_tree
-> get_tree_bdev
  -> fill_super
    -> erofs_fc_fill_super

When erofs_register_sysfs fails in the calling kobject_init_and_add,
it just returned an error code and the parent function will call
deactivate_locked_super to do clean up.

In the following stack trace, it finally calls erofs_unregister_sysfs
without knowing the execution status of erofs_register_sysfs, which
leads to the kobject bug.

 erofs_unregister_sysfs+0x46/0x60 fs/erofs/sysfs.c:225
 erofs_put_super+0x37/0xb0 fs/erofs/super.c:771
 generic_shutdown_super+0x14c/0x400 fs/super.c:465
 kill_block_super+0x97/0xf0 fs/super.c:1397
 erofs_kill_sb+0x60/0x190 fs/erofs/super.c:752
 deactivate_locked_super+0x94/0x160 fs/super.c:335
 get_tree_bdev+0x573/0x760 fs/super.c:1297

I am not sure how to fix this bug. Any suggestion is appreciated.

--
My best regards to you.

     No System Is Safe!
     Dongliang Mu
