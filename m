Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AC042803C55
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Dec 2023 19:07:28 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Mb2qTsIk;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SkWpg2yvpz3cVP
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Dec 2023 05:07:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Mb2qTsIk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=htejun@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SkWpX4LcCz3cQD
	for <linux-erofs@lists.ozlabs.org>; Tue,  5 Dec 2023 05:07:15 +1100 (AEDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6ce46470647so821729b3a.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 04 Dec 2023 10:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701713230; x=1702318030; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vnKGL9rVmaXJ0k7UQTGGb8qgGBw3yaFYXulmlj0ClVk=;
        b=Mb2qTsIkrWM9Gx1+eShmnAnXPrmCOLcuGecEPuP0vKrOrwNxLugyS0dHBmfMSyE3WW
         dK/Hkgp2hu4NSXV1HqhzS8F39xQ8ol8u2S8GIgVRZ3J+9KgDPjT+RkUYQIcoBb4gxBGE
         xpNt779N2E+ht/Q/Ej6/JeswQCbcVCViYQH2Y5LgTtftNga+oaGmMDdUxXjWz+k3Lx/v
         8F+2y2WdaBgfbxtNmgtgiFZL7dn1CYhrDKQ9dIyHxB8ma5qs6JGfw0RbWNwlLKAJ0O/y
         NlnzQpqlZM7gBb7jmV2z6AYGzqX6arO8zHL81ndS3VyCFoIPOV2jj1IcOv7CIPstry+n
         25ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701713230; x=1702318030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnKGL9rVmaXJ0k7UQTGGb8qgGBw3yaFYXulmlj0ClVk=;
        b=dAxtNy6Kk2/h61I/YwUyS9XaRqM5o+9/bfQckYTq9WoLCCvF2wC+Pb+k1Q9CXZaDmL
         jyMN/EKh7RRW1pkMxGZivKeznOrF+4BMRV4xK545g99XjzBmYBuDR4wzYnlLrKlJrVMN
         KsV9O/rCSM1lczBclXDeDownojVmU/ziBf/AV2IuvUV8t8+mF7flQrx7tIjVB3yilWgy
         Lh3vlje83GbMxjDLx6MvehvWKBNUvInyshnX4WKSdyae8StzDUe6A+pJ/X+B9SCfeNc1
         zB6V0JzylJOtV8CPMP1vk+ZYaeSsHbxny1VD5p7Hn1wMjr2xlYvdvFSsn/XZWDChnrMP
         xi/w==
X-Gm-Message-State: AOJu0YxGm1HIr52mpw4x+3XhlPohSrxaBUANYcGQ6cTrxwli/YjitX6n
	l2gvXL3SzNB7QbXj88ANRGY=
X-Google-Smtp-Source: AGHT+IGDIGeeBa7UWPj4E4w2SIGHBjZgGz8oxGqwAWzNb+KD7mpnEvIno4bt3NIHORxil3wMtNwC4w==
X-Received: by 2002:a05:6a20:1448:b0:18c:374c:6e64 with SMTP id a8-20020a056a20144800b0018c374c6e64mr27716780pzi.36.1701713229690;
        Mon, 04 Dec 2023 10:07:09 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:27ef])
        by smtp.gmail.com with ESMTPSA id u2-20020a056a00158200b006cdd507ca2esm7943470pfk.167.2023.12.04.10.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 10:07:09 -0800 (PST)
Date: Mon, 4 Dec 2023 08:07:07 -1000
From: Tejun Heo <tj@kernel.org>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: Performance drop due to alloc_workqueue() misuse and recent
 change
Message-ID: <ZW4VS3Z0auYCjg-W@slm.duckdns.org>
References: <dbu6wiwu3sdhmhikb2w6lns7b27gbobfavhjj57kwi2quafgwl@htjcc5oikcr3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbu6wiwu3sdhmhikb2w6lns7b27gbobfavhjj57kwi2quafgwl@htjcc5oikcr3>
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
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "gfs2@lists.linux.dev" <gfs2@lists.linux.dev>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "oss-drivers@corigine.com" <oss-drivers@corigine.com>, "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>, "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>, "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>, "open-iscsi@googlegroups.com" <open-iscsi@googlegroups.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.
 org>, "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>, "coreteam@netfilter.org" <coreteam@netfilter.org>, "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "wireguard@lists.zx2c4.com" <wireguard@lists.zx2c4.com>, "nbd@other.debian.org" <nbd@other.debian.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-fscrypt@vger.kernel.org" <linux-fscrypt@vger.kernel.org>, "ntb@lists.linux.dev" <ntb@lists.linux.dev>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>, "linux-nfs@
 vger.kernel.org" <linux-nfs@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hello,

On Mon, Dec 04, 2023 at 04:03:47PM +0000, Naohiro Aota wrote:
> Recently, commit 636b927eba5b ("workqueue: Make unbound workqueues to use
> per-cpu pool_workqueues") changed WQ_UNBOUND workqueue's behavior. It
> changed the meaning of alloc_workqueue()'s max_active from an upper limit
> imposed per NUMA node to a limit per CPU. As a result, massive number of
> workers can be running at the same time, especially if the workqueue user
> thinks the max_active is a global limit.
> 
> Actually, it is already written it is per-CPU limit in the documentation
> before the commit. However, several callers seem to misuse max_active,
> maybe thinking it is a global limit. It is an unexpected behavior change
> for them.

Right, and the behavior has been like that for a very long time and there
was no other way to achieve reasonable level of concurrency, so the current
situation is expected.

> For example, these callers set max_active = num_online_cpus(), which is a
> suspicious limit applying to per-CPU. This config means we can have nr_cpu
> * nr_cpu active tasks working at the same time.

Yeah, that sounds like a good indicator.

> fs/f2fs/data.c: sbi->post_read_wq = alloc_workqueue("f2fs_post_read_wq",
> fs/f2fs/data.c-                                          WQ_UNBOUND | WQ_HIGHPRI,
> fs/f2fs/data.c-                                          num_online_cpus());
> 
> fs/crypto/crypto.c:     fscrypt_read_workqueue = alloc_workqueue("fscrypt_read_queue",
> fs/crypto/crypto.c-                                              WQ_UNBOUND | WQ_HIGHPRI,
> fs/crypto/crypto.c-                                              num_online_cpus());
> 
> fs/verity/verify.c:     fsverity_read_workqueue = alloc_workqueue("fsverity_read_queue",
> fs/verity/verify.c-                                               WQ_HIGHPRI,
> fs/verity/verify.c-                                               num_online_cpus());
> 
> drivers/crypto/hisilicon/qm.c:  qm->wq = alloc_workqueue("%s", WQ_HIGHPRI | WQ_MEM_RECLAIM |
> drivers/crypto/hisilicon/qm.c-                           WQ_UNBOUND, num_online_cpus(),
> drivers/crypto/hisilicon/qm.c-                           pci_name(qm->pdev));
> 
> block/blk-crypto-fallback.c:    blk_crypto_wq = alloc_workqueue("blk_crypto_wq",
> block/blk-crypto-fallback.c-                                    WQ_UNBOUND | WQ_HIGHPRI |
> block/blk-crypto-fallback.c-                                    WQ_MEM_RECLAIM, num_online_cpus());
> 
> drivers/md/dm-crypt.c:          cc->crypt_queue = alloc_workqueue("kcryptd/%s",
> drivers/md/dm-crypt.c-                                            WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM | WQ_UNBOUND,
> drivers/md/dm-crypt.c-                                            num_online_cpus(), devname);

Most of these work items are CPU bound but not completley so. e.g.
kcrypt_crypt_write_continue() does wait_for_completion(), so setting
max_active to 1 likely isn't what they want either. They mostly want some
reasonable system-wide concurrency limit w.r.t. the CPU count while keeping
some level of flexibility in terms of task placement.

The previous max_active wasn't great for this because its meaning changed
depending on the number of nodes. Now, the meaning doesn't change but it's
not really useful for the above purpose. It's only useful for avoiding
melting the system completely.

One way to go about it is to declare that concurrency level management for
unbound workqueue is on users but that seems not ideal given many use cases
would want it anyway.

Let me think it over but I think the right way to go about it is going the
other direction - ie. making max_active apply to the whole system regardless
of the number of nodes / ccx's / whatever.

> Furthermore, the change affects performance in a certain case.
> 
> Btrfs creates several WQ_UNBOUND workqueues with a default max_active =
> min(NRCPUS + 2, 8). As my machine has 96 CPUs with NUMA disabled, this
> max_active config allows running over 700 active works. Before the commit,
> it is limited to 8 if NUMA is disabled or limited to 16 if NUMA nodes is 2.
> 
> I reverted the workqueue code back to before the commit, and I ran the
> following fio command on RAID0 btrfs on 6 SSDs.
> 
> fio --group_reporting --eta=always --eta-interval=30s --eta-newline=30s \
>     --rw=write --fallocate=none \
>     --direct=1 --ioengine=libaio --iodepth=32 \
>     --filesize=100G \
>     --blocksize=64k \
>     --time_based --runtime=300s \
>     --end_fsync=1 \
>     --directory=${MNT} \
>     --name=writer --numjobs=32
> 
> By changing workqueue's max_active, the result varies.
> 
> - wq max_active=8   (intended limit by btrfs?)
>   WRITE: bw=2495MiB/s (2616MB/s), 2495MiB/s-2495MiB/s (2616MB/s-2616MB/s), io=753GiB (808GB), run=308953-308953msec
> - wq max_active=16  (actual limit on 2 NUMA nodes setup)
>   WRITE: bw=1736MiB/s (1820MB/s), 1736MiB/s-1736MiB/s (1820MB/s-1820MB/s), io=670GiB (720GB), run=395532-395532msec
> - wq max_active=768 (simulating current limit)
>   WRITE: bw=1276MiB/s (1338MB/s), 1276MiB/s-1276MiB/s (1338MB/s-1338MB/s), io=375GiB (403GB), run=300984-300984msec
> 
> The current performance is slower than the previous limit (max_active=16)
> by 27%, or it is 50% slower than the intended limit.  The performance drop
> might be due to contention of the btrfs-endio-write works. There are over
> 700 kworker instances were created and 100 works are on the 'D' state
> competing for a lock.
> 
> More specifically, I tested the same workload on the commit.
> 
> - At commit 636b927eba5b ("workqueue: Make unbound workqueues to use per-cpu pool_workqueues")
>   WRITE: bw=1191MiB/s (1249MB/s), 1191MiB/s-1191MiB/s (1249MB/s-1249MB/s), io=350GiB (376GB), run=300714-300714msec
> - At the previous commit = 4cbfd3de73 ("workqueue: Call wq_update_unbound_numa() on all CPUs in NUMA node on CPU hotplug")
>   WRITE: bw=1747MiB/s (1832MB/s), 1747MiB/s-1747MiB/s (1832MB/s-1832MB/s), io=748GiB (803GB), run=438134-438134msec
> 
> So, it is -31.8% performance down with the commit.
> 
> In summary, we misuse max_active, considering it is a global limit. And,
> the recent commit introduced a huge performance drop in some cases.  We
> need to review alloc_workqueue() usage to check if its max_active setting
> is proper or not.

Thanks a lot for the report. I think it's a lot more reasonable to assume
that max_active is global for unbound workqueues. The current workqueue
behavior is not very intuitive or useful. I'll try to find something more
reasonable. Thanks for the report and analysis. Much appreciated.

Thanks.

-- 
tejun
