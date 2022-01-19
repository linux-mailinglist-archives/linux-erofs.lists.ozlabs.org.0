Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985F1493B02
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Jan 2022 14:21:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jf5rm303kz30Ml
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Jan 2022 00:21:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=E9ZM3eDC;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=E9ZM3eDC; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jf5rb0Vvtz309W
 for <linux-erofs@lists.ozlabs.org>; Thu, 20 Jan 2022 00:21:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=+9su99qQAC8y6dKw8A2X//R/c9y7lfjPSaVbD0mlkIU=; b=E9ZM3eDC/vl/KH/yXJ7nUL6K/l
 NCWWJpsHYRu1Feq1U/7U3Dgps87a3su50/wTSrphRvKDrVOgB9onW0JgyDy/vWUXEEyBnzV09sV/v
 CjLzYgcKr9NmdAs+5tsVk4sPoXun8RfLC434MTzHuHdIZ5v8bNC5Yja1QEXMvMlb3u/TiVRKPRBXQ
 MFPBhW+gZ31Q8UGF4A7OHNlrmAUElpBpZGA/HkIJ/J7UdBGEsgdSgPD/3BVUxkb4in/WFk4NJkNjU
 ChPO1vBidjHj6rqG+FnVPCBrYCyERd3hp9apv88S/ATC6bT26oAkHbaWiVrg12fE3F3GBXn2Gy3i7
 Uf5OpMKw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nAAtU-00AsCu-PA; Wed, 19 Jan 2022 13:20:56 +0000
Date: Wed, 19 Jan 2022 13:20:56 +0000
From: Matthew Wilcox <willy@infradead.org>
To: JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v1 19/23] cachefiles: implement .demand_read() for demand
 read
Message-ID: <YegQOHs9yjIgu1Qi@casper.infradead.org>
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
 <20211227125444.21187-20-jefflexu@linux.alibaba.com>
 <YcndgcpQQWY8MJBD@casper.infradead.org>
 <47831875-4bdd-8398-9f2d-0466b31a4382@linux.alibaba.com>
 <99c94a78-58c4-f0af-e1d4-9aaa51bab281@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99c94a78-58c4-f0af-e1d4-9aaa51bab281@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com,
 joseph.qi@linux.alibaba.com, linux-cachefs@redhat.com,
 linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Jan 12, 2022 at 05:02:13PM +0800, JeffleXu wrote:
> I'm afraid IDR can't be replaced by xarray here. Because we need an 'ID'
> for each pending read request, so that after fetching data from remote,
> user daemon could notify kernel which read request has finished by this
> 'ID'.
> 
> Currently this 'ID' is get from idr_alloc(), and actually identifies the
> position of corresponding read request inside the IDR tree. I can't find
> similar API of xarray implementing similar function, i.e., returning an
> 'ID'.

xa_alloc().
