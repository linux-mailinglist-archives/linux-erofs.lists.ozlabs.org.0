Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C15F15F7A4
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Feb 2020 21:22:58 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48K4Z66P6ZzDqgr
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Feb 2020 07:22:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48K3s62DTzzDqZF
 for <linux-erofs@lists.ozlabs.org>; Sat, 15 Feb 2020 06:50:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=v3womVZzJfvJ/ZynJrzvKSuPFFEQ+5OZC1GleOd63lI=; b=mys1IIw2ciRDnnOg1+a/L/beW1
 7357IOcpU71f4WaOx5BF1LNC2w+18SN0vPkn0BAx47JJT1ekmHmdX8FSwWkmEYlpgtTfg19s9Abjz
 C63qA8m0b0CEy2AU9q7BlUDy99a16ZDwgMirXJrhg4DHrx0SPqZfihei8HMA11pjNBbVUpwLheoUP
 jvjy8FNDkU4VCt+tgQUnXJCoHFertNTu6iJOjBK/+hVJcmhn8+NpTpozWdqIMq0dPCfOJZW/tcUNw
 +8WmZZnCzebTqfb9kxxclwCAtZbdVOz7PFPt4fNiEzN9DwwuCPfQtrzfGXQYwl5+/DdizCTTOIeUg
 sfUqC+fA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j2gz8-0001km-Ao; Fri, 14 Feb 2020 19:50:46 +0000
Date: Fri, 14 Feb 2020 11:50:46 -0800
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 01/13] mm: Fix the return type of
 __do_page_cache_readahead
Message-ID: <20200214195046.GC7778@bombadil.infradead.org>
References: <20200211010348.6872-1-willy@infradead.org>
 <20200211010348.6872-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211010348.6872-2-willy@infradead.org>
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
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Feb 10, 2020 at 05:03:36PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> ra_submit() which is a wrapper around __do_page_cache_readahead() already
> returns an unsigned long, and the 'nr_to_read' parameter is an unsigned
> long, so fix __do_page_cache_readahead() to return an unsigned long,
> even though I'm pretty sure we're not going to readahead more than 2^32
> pages ever.

I was going through this and realised it's completely pointless -- the
returned value from ra_submit() and __do_page_cache_readahead() is
eventually ignored through all paths.  So I'm replacing this patch with
one that makes everything return void.
