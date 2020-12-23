Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8C42E1A29
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Dec 2020 09:54:20 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D16T531qMzDqSg
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Dec 2020 19:54:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+6038cc82e5bfdcb9912f+6331+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=jqhmPAN1; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D16Sy6b8nzDqS5
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Dec 2020 19:54:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=HKLhSP0AX849qe/seOGRQIG2LuIaRgQixYFEE7TpKGw=; b=jqhmPAN1ReUqMHRqF0T4Vd6e0q
 VLXL2XDuEDFIsDLVdCkvl8aHB4ZakK2ifrR9rSbsbiymIby144YrZWxZebkuAft7UINfIY5QYzQ+o
 KTTe7p24Nw6A6Ao+pIWfmi0la6gxevNOWLVlaakQYSDiADhO9f6eBtwFze32YhAP7Z+AgDdOELenT
 psPpmWbmS2BAZyRy6+xgPeF6YLiFSXVdpuXXj70ffdvnVg2TLAgObQF4QAd9+AytZ4ODQh2ozJaJ5
 9d6GyTTdodIYbOvpJSEyAO07wgmTaN9/lJkyZOify4TgG5d4/93uWynlZyP3qjhZwEWhBWeEdZUCv
 h1So9lkw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1krzuD-00006T-Qs; Wed, 23 Dec 2020 08:54:01 +0000
Date: Wed, 23 Dec 2020 08:54:01 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH] erofs: support direct IO for uncompressed file
Message-ID: <20201223085401.GA336@infradead.org>
References: <20201214140428.44944-1-huangjianan@oppo.com>
 <20201222142234.GB17056@infradead.org>
 <20201222193901.GA1892159@xiangao.remote.csb>
 <20201223074455.GA14729@infradead.org>
 <dc4452e9-83eb-90e7-f001-d39d0ecdd105@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc4452e9-83eb-90e7-f001-d39d0ecdd105@oppo.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: zhangshiming@oppo.com, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, guoweichao@oppo.com,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Dec 23, 2020 at 04:48:20PM +0800, Huang Jianan wrote:
> Hi Christoph,
> 
> The reason we use dio is because we need to deploy the patch on some early
> kernel versions, and we don't pay much attention to the change of iomap.

No, that is never an excuse for upstream development.
