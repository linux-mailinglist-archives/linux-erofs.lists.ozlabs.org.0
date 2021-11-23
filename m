Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4597B45AEA5
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Nov 2021 22:48:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HzHp20xwlz2yYJ
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 08:48:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel-com.20210112.gappssmtp.com header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=VQApAlck;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2607:f8b0:4864:20::636;
 helo=mail-pl1-x636.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20210112.gappssmtp.com
 header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=VQApAlck; dkim-atps=neutral
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HzHnv62ljz2yNr
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Nov 2021 08:48:35 +1100 (AEDT)
Received: by mail-pl1-x636.google.com with SMTP id b11so166278pld.12
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Nov 2021 13:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TYkPf9vJ648gXjsCEnGEexU4+Ifkiqg1wwbcGn6CCJ4=;
 b=VQApAlcktwMcpaq5jFhkMxeNGyvexkKC3i6bBW7J48mF8DsF1/7CQAqKNzOE+eTccI
 MukZz7spVxbYqcrXVw8V1NPJ/pO4n52l7m+S0Ph4Ybr+mw2kgqAqtZa3pLex/+BZstf8
 /wFsj02Qj6TChPn0/3voEI1RYYWUipBK72irmVx+QhYrnrndgBztGcQeijJ0cPmWiSB8
 zysPKFzjgdDt9boZOOp48eyCMBg3PV9MBTwiNrvClt0hBzUO02OKjJgpyz/mrusiP8R+
 CYs52zo3lmHwTSmYl1Jahz6zyoWzMdW1LqR6lyuLMEqjEjPScDcZZh/xx6IU/yB7SEwD
 h9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TYkPf9vJ648gXjsCEnGEexU4+Ifkiqg1wwbcGn6CCJ4=;
 b=M99GlK88z0NSwh0ghSFyDB7mHMyhtSOZQKcrQ3x9UOh+DvSeOMLETLtZxXDQ3sXboO
 05IXVEtaCqy26mPL/VdHM+EWMw64WIzbYrHCRJGAVHYiYYMU5mUK9mZlRwZFA3zVOKaT
 RQQTqkcqSDPzKZl6ng25XA9VDj5KPyOUCubQsR9ly60s0fBBhER8jLhQk5d4vabDMPrd
 r0ReebDyz+mFktwYBAPV+H6a/M2Ac1QT+pr3YzKGOTn7ViylFhwJN4jq2Nu/dUXoTHt/
 RjDIm+I/LoM9foA4A/fqQE0reDFp8o/TeggGejNvPvBwLaqxQp7oGoeHKBohuRYyhnEJ
 kKfQ==
X-Gm-Message-State: AOAM531AhlWEo1ZT5PuWJgCpUDLYK1Cd+bfNE90+rTRXSQNhRGWH20p4
 338+ENPbPrMnyvSnX5x+6Ovz9t3R3I0PXoWfnZkP2A==
X-Google-Smtp-Source: ABdhPJyT9foSDeohZagrJ9StTFco2dwZgw3K6Q2oNHo7YSNAudlmobBOmJCjxwVnaF6MiMXxVYrJ5EOKlp8j1MbCkKE=
X-Received: by 2002:a17:90a:e7ca:: with SMTP id
 kb10mr7435174pjb.8.1637704113737; 
 Tue, 23 Nov 2021 13:48:33 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-20-hch@lst.de>
In-Reply-To: <20211109083309.584081-20-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Nov 2021 13:48:23 -0800
Message-ID: <CAPcyv4isfhSxr+MJnw2UBCFN_3_dCzwAjJERHzycnR5Ncy2RQQ@mail.gmail.com>
Subject: Re: [PATCH 19/29] ext2: cleanup the dax handling in ext2_fill_super
To: Christoph Hellwig <hch@lst.de>
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
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>, Mike Snitzer <snitzer@redhat.com>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org,
 linux-xfs <linux-xfs@vger.kernel.org>,
 device-mapper development <dm-devel@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Only call fs_dax_get_by_bdev once the sbi has been allocated and remove
> the need for the dax_dev local variable.

Looks good.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
