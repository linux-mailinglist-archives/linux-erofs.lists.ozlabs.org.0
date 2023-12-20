Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25454819936
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Dec 2023 08:15:21 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WT4D9X8+;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Sw4Zr5p2fz30hC
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Dec 2023 18:15:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WT4D9X8+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=htejun@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Sw4Zg5cjcz305T
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 Dec 2023 18:15:05 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d3ec3db764so2104305ad.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 19 Dec 2023 23:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703056501; x=1703661301; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eJqWdKRl0UBq0Wj+r8chL9QmhrnrulM60eoe1tH98KY=;
        b=WT4D9X8+enfBovCLoM0rGIQo4g8gnUYN6Uy2VEUHmX4rIOIAPuj5g0EZIvXNs/dJT7
         3VFkT6iy0nO6sB36LAleqI5X8xTIN2FkhjPTGSs/tGh6Rw4/9cXNxCz8+odveCzh0ltC
         +VSphJdzGQ5RDZgVfv3VWjHdbIfFp1UoZaWqN4m+s0tyfZ38FTFLAMT6jmXYh2b/954s
         UcJmKk5PJRQ+b8OLj+wqzQj+ewBRf0oT4C56wZsUEB1rXql/PqxFb4gXUc2diAXZyL77
         okqiad8Y0xPampg1gtXxHt8ZVc+S0aJbIlxklqeH9wL/pQ61X6OHEay8wLvwbohAq4dz
         saPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703056501; x=1703661301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJqWdKRl0UBq0Wj+r8chL9QmhrnrulM60eoe1tH98KY=;
        b=gTBNS7/lvAoJHGhaXV3bVAHOTt4RMH1aI82l/EJhdLUVnH6VshuDNlpha8NKiNmxk/
         ro1+qGyJciFACgm0tsavGa25vbDVgA3cIoALhzU9fMDqnxPbTJ7MgtNXrc2+R9XoXR9F
         macjOEkJx7/Zq09PmwXh+FT5kvIk7wehJIqpXcv+miwWo88BtbY83GQNzS5R7GygJ4H4
         00NNhhtLE7qHx4y63OzVd1uSxkkZSe3kyUxj1mxNvmX763Yk0yU/NvonzVoR2eaAJ5Zs
         u+QfYWxmI7lKAPsJFlPtRRLrUZsO/SFN66ubvW047/iHaefdH/+3UpYVdh2Nll6fdzDR
         NbFQ==
X-Gm-Message-State: AOJu0Yy7mGg0RTgJDT3g1QBxQoQnsan2+QeF+Avycvk9Wl7n9d9W5T3O
	q26xKjT8xEqskDByN4BigBo=
X-Google-Smtp-Source: AGHT+IH2/KQGWsEEIk+CfQb//I/X1FN9i9PYn0R8hU2YQDfX0MobECujamcRsnvnV4o1L8WIa9T7SQ==
X-Received: by 2002:a17:903:947:b0:1d3:be34:7862 with SMTP id ma7-20020a170903094700b001d3be347862mr3583611plb.9.1703056501427;
        Tue, 19 Dec 2023 23:15:01 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902bb8200b001cfd2cb1907sm22210314pls.206.2023.12.19.23.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 23:15:00 -0800 (PST)
Date: Tue, 19 Dec 2023 21:14:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: Performance drop due to alloc_workqueue() misuse and recent
 change
Message-ID: <ZYKUc7MUGvre2lGQ@slm.duckdns.org>
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

Hello, again.

On Mon, Dec 04, 2023 at 04:03:47PM +0000, Naohiro Aota wrote:
...
> In summary, we misuse max_active, considering it is a global limit. And,
> the recent commit introduced a huge performance drop in some cases.  We
> need to review alloc_workqueue() usage to check if its max_active setting
> is proper or not.

Can you please test the following branch?

 https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git unbound-system-wide-max_active

Thanks.

-- 
tejun
