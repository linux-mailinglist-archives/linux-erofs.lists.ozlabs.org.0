Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1039E78BDC8
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Aug 2023 07:32:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RZbfm4pkdz2y1b
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Aug 2023 15:32:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RZbff5prJz2yVZ
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Aug 2023 15:32:41 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vqq90M._1693287151;
Received: from 30.25.201.82(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vqq90M._1693287151)
          by smtp.aliyun-inc.com;
          Tue, 29 Aug 2023 13:32:33 +0800
Message-ID: <f95551ca-6785-3d3b-18e4-9846323b1d87@linux.alibaba.com>
Date: Tue, 29 Aug 2023 13:32:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [syzbot] [erofs?] WARNING in erofs_kill_sb
To: syzbot <syzbot+69c477e882e44ce41ad9@syzkaller.appspotmail.com>,
 brauner@kernel.org, hch@lst.de, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000e5e02b0604080b49@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <000000000000e5e02b0604080b49@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/8/29 12:14, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-and-tested-by: syzbot+69c477e882e44ce41ad9@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         1c59d383 Merge tag 'linux-kselftest-nolibc-6.6-rc1' of..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=14f819dfa80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9678e210dd5e4a5f
> dashboard link: https://syzkaller.appspot.com/bug?extid=69c477e882e44ce41ad9
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Note: no patches were applied.
> Note: testing is done by a robot and is best-effort only.

#syz invalid

since commit 4da3c7183e18 ("erofs: drop unnecessary WARN_ON() in
erofs_kill_sb()") merged ahead of

fs: open block device after superblock creation

so this issue only existed in some previous -next versions.
This report doesn't impact anything upstream.

Thanks,
Gao Xiang
