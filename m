Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8092A3A99
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Nov 2020 03:51:08 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CQDn41zNpzDqSL
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Nov 2020 13:51:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=gZt9yAkr; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gZt9yAkr; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CQDmq6Dd6zDqQV
 for <linux-erofs@lists.ozlabs.org>; Tue,  3 Nov 2020 13:50:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604371847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CW/ACUV2Mng49qFZGRiWeYHvjBj6rU/+vNlelQ6F/Jg=;
 b=gZt9yAkrMnyicYN6MaiNWr6LGRTtEIyIx6TEJvRBOrxHIqlR6aV3s/B5UCEv318wL8USIu
 jV92iNBCOJzNx0NHNoeKs3Yrel3kksQPHJpZ7oqa2PQB0vSVTgROpQNPkPFQIoX+29Dhl8
 bcNQVvRjZsL/Ua1eO7Zkh4O8gcAXhBk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604371847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CW/ACUV2Mng49qFZGRiWeYHvjBj6rU/+vNlelQ6F/Jg=;
 b=gZt9yAkrMnyicYN6MaiNWr6LGRTtEIyIx6TEJvRBOrxHIqlR6aV3s/B5UCEv318wL8USIu
 jV92iNBCOJzNx0NHNoeKs3Yrel3kksQPHJpZ7oqa2PQB0vSVTgROpQNPkPFQIoX+29Dhl8
 bcNQVvRjZsL/Ua1eO7Zkh4O8gcAXhBk=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-GRd8wm8eNTKFuPeXHBWwWw-1; Mon, 02 Nov 2020 21:50:45 -0500
X-MC-Unique: GRd8wm8eNTKFuPeXHBWwWw-1
Received: by mail-pg1-f197.google.com with SMTP id v2so3371431pgv.2
 for <linux-erofs@lists.ozlabs.org>; Mon, 02 Nov 2020 18:50:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=CW/ACUV2Mng49qFZGRiWeYHvjBj6rU/+vNlelQ6F/Jg=;
 b=XKHWjWONtBsuDktYamJMEmPkO6j0tmP95oNxord3PVpPBCaEkNPRKezsrr/bSewpwR
 PFFI14lAWLP/8Vt3V3DvLcfefeLBs6J/10I0WVWumEr36ebBoK02ysyl6tPEN2FFxM65
 uQOX38aVfWtGxEv1HnVTN6pbwCbyK3DNC8NSFqF2RmRfmEnvKaWbao8rCTW8BtTPPK1D
 dcu3OcQIx5TEHDO2ZwBR4RSOf7Xu3LDTXpC1iTSt4YLouj19nalhapRrXTK8UkgKXvXi
 g4NuMgGMQalxqRTdS9Yh6nS0LBXbuv8yZBoMnbpMjQ0SCtkwhdpC+okzCPH4j9kvb+bL
 W96w==
X-Gm-Message-State: AOAM531WcMlke/t7epw14nL31aPZz3Conq4BeC0uJKdCmtk84bitU6Hw
 PpF6w+iteexWq1qD1syrmx6B0SifQrN/QrUPbBEuBQgD4UgkzRqWTxmKhSfou8WqOuljXL3oUp6
 +Kh90JQetcJEXcxQ//HdzznJ2
X-Received: by 2002:a17:90b:684:: with SMTP id
 m4mr1300033pjz.133.1604371844707; 
 Mon, 02 Nov 2020 18:50:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxgqZp4MURbMJ28PFb6nSGA5bU2+CHwFJgndLAIBQBWizeUfCGjfADDys+ArVZnBuIwNraXpw==
X-Received: by 2002:a17:90b:684:: with SMTP id
 m4mr1300005pjz.133.1604371844358; 
 Mon, 02 Nov 2020 18:50:44 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id v3sm830911pju.38.2020.11.02.18.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 18:50:43 -0800 (PST)
Date: Tue, 3 Nov 2020 10:50:33 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] erofs: derive atime instead of leaving it empty
Message-ID: <20201103025033.GA788000@xiangao.remote.csb>
References: <20201031195102.21221-1-hsiangkao.ref@aol.com>
 <20201031195102.21221-1-hsiangkao@aol.com>
MIME-Version: 1.0
In-Reply-To: <20201031195102.21221-1-hsiangkao@aol.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
Cc: nl6720 <nl6720@gmail.com>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chao,

On Sun, Nov 01, 2020 at 03:51:02AM +0800, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@redhat.com>
> 
> EROFS has _only one_ ondisk timestamp (ctime is currently
> documented and recorded, we might also record mtime instead
> with a new compat feature if needed) for each extended inode
> since EROFS isn't mainly for archival purposes so no need to
> keep all timestamps on disk especially for Android scenarios
> due to security concerns. Also, romfs/cramfs don't have their
> own on-disk timestamp, and squashfs only records mtime instead.
> 
> Let's also derive access time from ondisk timestamp rather than
> leaving it empty, and if mtime/atime for each file are really
> needed for specific scenarios as well, we can also use xattrs
> to record them then.
> 
> Reported-by: nl6720 <nl6720@gmail.com>
> [ Gao Xiang: It'd be better to backport for user-friendly concern. ]
> Fixes: 431339ba9042 ("staging: erofs: add inode operations")
> Cc: stable <stable@vger.kernel.org> # 4.19+
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>

May I ask for some extra free slots to review this patch plus 
[PATCH 1/4] of 
https://lore.kernel.org/r/20201022145724.27284-1-hsiangkao@aol.com

since it'd be also in linux-next for a while before sending out
to Linus. And the debugging messages may also be an annoying
thing for users.

Thanks a lot!

Thanks,
Gao Xiang

