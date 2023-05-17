Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBCC707087
	for <lists+linux-erofs@lfdr.de>; Wed, 17 May 2023 20:15:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QM1Vm5df8z3f7s
	for <lists+linux-erofs@lfdr.de>; Thu, 18 May 2023 04:15:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QM1Vf6Y2tz3f5w
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 May 2023 04:15:21 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VitiUur_1684347313;
Received: from 30.13.129.94(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VitiUur_1684347313)
          by smtp.aliyun-inc.com;
          Thu, 18 May 2023 02:15:16 +0800
Message-ID: <85c61aae-6716-9936-1533-91624f70eefe@linux.alibaba.com>
Date: Thu, 18 May 2023 02:15:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [syzbot] [erofs?] general protection fault in erofs_bread (2)
To: syzbot <syzbot+bbb353775d51424087f2@syzkaller.appspotmail.com>,
 chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 xiang@kernel.org
References: <000000000000d03b0805fbe71d55@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <000000000000d03b0805fbe71d55@google.com>
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



On 2023/5/18 10:35, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f1fcbaa18b28 Linux 6.4-rc2
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=114aa029280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6beb6ffe4f59ef2a
> dashboard link: https://syzkaller.appspot.com/bug?extid=bbb353775d51424087f2
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13dd834e280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167ef106280000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/4adf207e9d5e/disk-f1fcbaa1.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/9e7cce92f611/vmlinux-f1fcbaa1.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/cfd911b80f89/bzImage-f1fcbaa1.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/a2583fbaaf14/mount_2.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+bbb353775d51424087f2@syzkaller.appspotmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git fixes
