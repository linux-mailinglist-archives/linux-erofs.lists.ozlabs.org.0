Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2326765F0A6
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Jan 2023 16:59:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Nnrkj129Wz3bVy
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Jan 2023 02:59:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45; helo=out30-45.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Nnrkb5sp6z2xHH
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Jan 2023 02:59:18 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VYwMxZY_1672934349;
Received: from 30.27.95.191(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VYwMxZY_1672934349)
          by smtp.aliyun-inc.com;
          Thu, 05 Jan 2023 23:59:11 +0800
Message-ID: <03ada837-2504-9e69-5fec-0b7a7f186d90@linux.alibaba.com>
Date: Thu, 5 Jan 2023 23:59:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [syzbot] [erofs?] WARNING: CPU: NUM PID: NUM at
 mm/page_alloc.c:LINE get_page_from_freeli
To: Aleksandr Nogikh <nogikh@google.com>
References: <000000000000c0a08805f07291a0@google.com>
 <f126fc95-fdbe-cc2e-5efb-ab704d13bd41@linux.alibaba.com>
 <CANp29Y63rCdepVtantxdJEcvbRv0D61gfY_oGV7dgrmEGgPdLw@mail.gmail.com>
From: Xiang Gao <hsiangkao@linux.alibaba.com>
In-Reply-To: <CANp29Y63rCdepVtantxdJEcvbRv0D61gfY_oGV7dgrmEGgPdLw@mail.gmail.com>
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
Cc: syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-erofs@lists.ozlabs.org, syzbot <syzbot+c3729cda01706a04fb98@syzkaller.appspotmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


Hi Aleksandr,

On 2023/1/5 19:14, Aleksandr Nogikh wrote:
> Hi,
> 
> On Thu, Jan 5, 2023 at 11:54 AM Xiang Gao <hsiangkao@linux.alibaba.com> wrote:
> 
>> I wasn't able to build the kernel with this kernel config, it shows:
>> "...
>> FATAL: modpost: vmlinux.o is truncated. sechdrs[i].sh_offset=1399394064 > sizeof(*hrd)=64
>> make[2]: *** [Module.symvers] Error 1
>> make[1]: *** [modpost] Error 2
>> make: *** [__sub-make] Error 2
>> "
> 
> Could you please tell, what exact compiler/linker version did you use?

Thanks for your help.

GCC 9.2.1 on my developping server.

> 
> 
>>>
>>> Downloadable assets:
>>> disk image: https://storage.googleapis.com/syzbot-assets/0c8a5f06ceb3/disk-f9ff5644.raw.xz
>>> vmlinux: https://storage.googleapis.com/syzbot-assets/be222e852ae2/vmlinux-f9ff5644.xz
>>> kernel image: https://storage.googleapis.com/syzbot-assets/d9f42a53b05e/bzImage-f9ff5644.xz
>>
>> Finally I tried the original kernel image, and it printed some other
>> random bug when booting system and then reboot, like:
>>
>> [   36.991123][    T1] ==================================================================
>> [   36.991800][    T1] BUG: KASAN: slab-out-of-bounds in copy_array+0x96/0x100
>> [   36.992438][    T1] Write of size 32 at addr ffff888018c34640 by task systemd/1
> < .. >
> 
> Interesting!
> I've just tried to boot it with qemu and it was fine.
> 
> qemu-system-x86_64 -smp 2,sockets=2,cores=1 -m 4G -drive
> file=disk-f9ff5644.raw,format=raw -snapshot -nographic -enable-kvm
> 
> So it looks like it's some difference between these VMMs that causes
> that bug to fire.

I think the problem is that the rootfs which I used has more complicated
workload than the given one.

> 
>>
>> May I ask it can be reproducable on the latest -rc kernel?
> 
> We can ask syzbot about v6.2-rc2:
> 
> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
> 88603b6dc419445847923fcb7fe5080067a30f98

I think I know the root cause: It seems that kvcalloc doesn't support
GFP_NOFAIL, I will use kcalloc directly instead.

Thanks,
Gao Xiang

> 
>>
>> Thanks,
>> Gao Xiang
>>
> 
> --
> Aleksandr
