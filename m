Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E94C415FBEE
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Feb 2020 02:16:10 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48KC4P2RGczDqnT
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Feb 2020 12:16:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=pp4+jYrd; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48KC4C1H6hzDqmh
 for <linux-erofs@lists.ozlabs.org>; Sat, 15 Feb 2020 12:15:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=rLBAYvHDyQG068qFXc4PKikpMZL0O5lvrEMnkVr84hY=; b=pp4+jYrdtIiCu1ZmQd3UA6AYr/
 85A+NhPrb4RLR40lY3uBj4FXFTAWs54cubURwUY781EoXTIC1BHmzzNCBvBY8CryBQxMU/K9kCyDD
 Uej9VEruUNuHLfKPM4kfSaYvl7cRuRpvE6a4DUQXDHXn67rTy5ieMKlxLHoaPREJTum8bIQ9MN9Gw
 zdza5RTyE51eZi3yeNdHM+vbtFO0NAVQHI+/F7pxpuo7utWxpPvSsEQWVwOfY7b3Djjfu7uYZbJKq
 pEcZMax/EA/FGJvJyodBK0tcSq1rmhd9c8O3RFfEaCuHnm/yRy6hPamomhAD6zwSpAIRbrf8oTm28
 VPquc2zA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j2m3k-00083J-V5; Sat, 15 Feb 2020 01:15:52 +0000
Date: Fri, 14 Feb 2020 17:15:52 -0800
From: Matthew Wilcox <willy@infradead.org>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v5 03/13] mm: Put readahead pages in cache earlier
Message-ID: <20200215011552.GE7778@bombadil.infradead.org>
References: <20200211010348.6872-1-willy@infradead.org>
 <20200211010348.6872-4-willy@infradead.org>
 <b0cdd7b4-e103-a884-d8f7-2378905f7b3b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0cdd7b4-e103-a884-d8f7-2378905f7b3b@nvidia.com>
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
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Feb 13, 2020 at 07:36:38PM -0800, John Hubbard wrote:
> I see two distinct things happening in this patch, and I think they want to each be
> in their own patch:
> 
> 1) A significant refactoring of the page loop, and
> 
> 2) Changing the place where the page is added to the page cache. (Only this one is 
>    mentioned in the commit description.)
> 
> We'll be more likely to spot any errors if these are teased apart.

Thanks.  I ended up splitting this patch into three, each hopefully
easier to understand.
