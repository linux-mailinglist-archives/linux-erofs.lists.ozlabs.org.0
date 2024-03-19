Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A2287FBA1
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Mar 2024 11:17:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TzSMG1pPXz3dKY
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Mar 2024 21:17:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.69; helo=mail-io1-f69.google.com; envelope-from=3hmb5zqkbaacz56rhsslyhwwpk.nvvnsl1zlyjvu0lu0.jvt@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TzSM81wFJz2yk7
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 Mar 2024 21:17:06 +1100 (AEDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc7a930922so169444239f.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 19 Mar 2024 03:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710843423; x=1711448223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wadArb7ioUuvUbDXFt8TyPvnnpuh5PkttRsGrkiB34M=;
        b=WsrLttRws8r75I3khdDKJtbGavOIqekArAm+tRdXTpAHCKR+JYxgCIbPHhqkcFCtvf
         jGleGUi66TixIUZ7+MKeqNHne9lmz4m1f6Qt5yW9SShNxDUpJDlS9zcZ4BN8LcHdlWse
         p3THU+HLoOh793+thUucVg443atJmVjC0g9LgE1V2G2kMfsdrr+T3mYQaQjptEJeKGWx
         hXO8OiaUWriO7v4Cv8e9WHbqwBxdrrxPli1V02g/gQRWJiEDpgz3sRHl1vcc+2NmRq7M
         yGASk470XECGu9nrKRTQuKao9dNT+lswRApkq6RTk1LU+gdrzpPtB+0G4hr+tcYfvngK
         taew==
X-Forwarded-Encrypted: i=1; AJvYcCXASKXZfWfE3HikH37srRUdCyWSEev2VAd+tOfhwTY5JiGw8eL2Si7OYLhdxflir7lvcuj3iZMkw+lDI5y6WVEhjPahHBY//A0a6QI3
X-Gm-Message-State: AOJu0YzLn2YMcXCWzplqek6CVYm/TXC+6vluEhBaP+VSfcvQGIFJrmJH
	nkFcH7ZF0QNfQFRvV3P9gII7dqc4pp0uz0vGtRExrHsZElcFTZY/Qp6rqw0Xbevh1XVjnaKybDl
	ROCh6/a7mXO1vVnGaNW/o7e94fChuP91akx6eT6zqftD5nj2sxjujPVw=
X-Google-Smtp-Source: AGHT+IGRQsfBjCGsWM3fwH85+e65cL9FrhgEtaxanxYQibCmBtEPlngDGB2JJhqAW+e6QGmHjUG2sYpRDZYn208fTyvoUyb9Y/pu
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8923:b0:476:d06e:8f1c with SMTP id
 jc35-20020a056638892300b00476d06e8f1cmr99181jab.2.1710843422961; Tue, 19 Mar
 2024 03:17:02 -0700 (PDT)
Date: Tue, 19 Mar 2024 03:17:02 -0700
In-Reply-To: <4b007533-8d7b-40e7-9f06-52304b46cb8b@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e031e061400c64d@google.com>
Subject: Re: [syzbot] [erofs?] KMSAN: uninit-value in z_erofs_lz4_decompress (3)
From: syzbot <syzbot+88ad8b0517a9d3bb9dc8@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xiang@kernel.org
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+88ad8b0517a9d3bb9dc8@syzkaller.appspotmail.com

Tested on:

commit:         b3603fcb Merge tag 'dlm-6.9' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14395479180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0f689e0798c5101
dashboard link: https://syzkaller.appspot.com/bug?extid=88ad8b0517a9d3bb9dc8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
