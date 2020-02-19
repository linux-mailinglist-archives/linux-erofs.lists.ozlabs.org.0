Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B27A1647AA
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 16:01:15 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48N1Bc2frMzDqPT
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Feb 2020 02:01:12 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=FbVPGaVt; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48N1BW1mdHzDqL2
 for <linux-erofs@lists.ozlabs.org>; Thu, 20 Feb 2020 02:01:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=dQq5UdvWp+QdydyVJRmEnvUTQNEYvIRUriwjl717Wo4=; b=FbVPGaVtVufC1cWxht/uSdu9LM
 u4inzXpj28Km884GMUnmZBZO/CLojvZi7gibEIxqwy5P16gRi74kIpFFlM3LmNzkK2VjQeGLm1PIN
 Ast9YJe2181MgGTKVtU4ay5LehVsSUfjLEqKWgKXAy8nNlOwI8zWX80DwX6CuU/UuAiBX+eo4CCHP
 Y81PP5VVxaEj/8tazt0cFvBWDXBOs9Ln2s3muutl3kguvTUKQ6dd4LkeHCQybnqB9Utkcyr9mBpK4
 yVPx2Lypjcjd5xEPJl6EzkzejWufd+ETMbK3W9ivGAB1WoW5AaZ+vd3KfWIaBSoF1nkRoP3ugUxQh
 XhutwZkQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j4QqV-0003kJ-Mw; Wed, 19 Feb 2020 15:01:03 +0000
Date: Wed, 19 Feb 2020 07:01:03 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v6 07/19] mm: Put readahead pages in cache earlier
Message-ID: <20200219150103.GQ24185@bombadil.infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-12-willy@infradead.org>
 <e3671faa-dfb3-ceba-3120-a445b2982a95@nvidia.com>
 <20200219144117.GP24185@bombadil.infradead.org>
 <20200219145246.GA29869@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219145246.GA29869@infradead.org>
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
Cc: linux-xfs@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Feb 19, 2020 at 06:52:46AM -0800, Christoph Hellwig wrote:
> On Wed, Feb 19, 2020 at 06:41:17AM -0800, Matthew Wilcox wrote:
> > #define readahead_for_each(rac, page)                                   \
> >         while ((page = readahead_page(rac)))
> > 
> > No more readahead_next() to forget to add to filesystems which don't use
> > the readahead_for_each() iterator.  Ahem.
> 
> And then kill readahead_for_each and open code the above to make it
> even more obvious?

Makes sense.
