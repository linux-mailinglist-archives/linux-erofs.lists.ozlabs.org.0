Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E61A45AC8C
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Nov 2021 20:34:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HzDpl6sD4z2ypn
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 06:34:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel-com.20210112.gappssmtp.com header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=jjyjzax1;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2607:f8b0:4864:20::42c;
 helo=mail-pf1-x42c.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20210112.gappssmtp.com
 header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=jjyjzax1; dkim-atps=neutral
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HzDpg2gmFz2xSH
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Nov 2021 06:34:02 +1100 (AEDT)
Received: by mail-pf1-x42c.google.com with SMTP id x5so340904pfr.0
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Nov 2021 11:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Hj7PcxuLnKzRepBdxbumr3rSJH1rp9RXoQiNS6BkqqY=;
 b=jjyjzax1feHZ07LUiZ/Yf1E9Hxm1wgDLlAZ2cYg6AJFLe/d321qFax/yEEu22m6fed
 iBHNc8Kk34bMQQ2nIQi6MEMltBfNwsAHFQR0AWSHQwNal+nFXc7edty5ia7jOUicLQW1
 FuRddFObFySh+nkUL24rBP+JDHWbRQRoHp4NV/QyPAV4R/iAhHEl65ZT4s43voxcaEMy
 Oc8zToerc/pGHUlRu2jWA79GIW6I3ZHT1zjOZ64ig8LsDtvPs4/T2LyRFd31HHpRYYun
 TIkUF+RfmunDs0Ue5w+xrykDMWgvw58GCXj/wKIs5Ax9Klji3Cu6QKxzZO3Z0ZwENfiJ
 dDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Hj7PcxuLnKzRepBdxbumr3rSJH1rp9RXoQiNS6BkqqY=;
 b=vgvWWFKiRyX0tTMrB6fxn7nVqKuTiGRSD1n0YUwWnxwp5ziJEMynPOJdYbB3ezCExQ
 D4C8dS/ATqsHJ+ilF86CuBAnPwkW0qxDddUIUrtfah+NON59SuI2egVowzqNDLAoXK3/
 Ml0MfmGJfSCHldOYgIlmtY4xkd9NRurE03q4oZMyRjJmKSeMRU9ZWvcAUNQo9f0mXLzp
 dinwis85NvbWnbHgCzyzQEBcmzx3FL7NMQDs319yGW0j5jLvnRibhM5kFMDZ6WdJ5Viy
 8LzjojfiI4jR9OrswJJCBKn6sSEhEy50GaCnDzmkdDPPBzqE3R7hszAmbDwRQcVclieA
 Cf6A==
X-Gm-Message-State: AOAM533wSzo8L0595E+oDHWxByJuJrLWSZLwO311A/MSsDwKjUH9QHw5
 j6RqBrZLUXK13aQOjkzFAiAa7YLkyeonDRM15EcgPA==
X-Google-Smtp-Source: ABdhPJzfbK/HXngr7c4SVqoUjU1z90TEgx7yZs5kS94X6ib8WevHTs6s6Lbm19DO5En0QIDCaOcGr0Q9P6r3KEtQ2kY=
X-Received: by 2002:a63:85c6:: with SMTP id u189mr5465536pgd.377.1637696035778; 
 Tue, 23 Nov 2021 11:33:55 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-5-hch@lst.de>
 <CAPcyv4ic=Mz_nr5biEoBikTBySJA947ZK3QQ9Mn=KhVb_HiwAA@mail.gmail.com>
 <20211123055742.GB13711@lst.de>
In-Reply-To: <20211123055742.GB13711@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Nov 2021 11:33:45 -0800
Message-ID: <CAPcyv4jd2eUo4bDfX=idG7js6W=L8uKKveG97r1a8DWa-pJ=mQ@mail.gmail.com>
Subject: Re: [PATCH 04/29] dax: simplify the dax_device <-> gendisk association
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

On Mon, Nov 22, 2021 at 9:58 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Nov 22, 2021 at 07:33:06PM -0800, Dan Williams wrote:
> > Is it time to add a "DAX" symbol namespace?
>
> What would be the benefit?

Just the small benefit of identifying DAX core users with a common
grep line, and to indicate that DAX exports are more intertwined than
standalone exports, but yeah those are minor.
