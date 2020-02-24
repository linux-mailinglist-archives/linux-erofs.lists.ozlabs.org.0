Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F3A16B358
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Feb 2020 22:54:58 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48RG7g6fx0zDqT5
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Feb 2020 08:54:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+fd4c774fa746ae91f5d1+6028+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=UH81cZnw; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48RG7Z6ZlpzDqSK
 for <linux-erofs@lists.ozlabs.org>; Tue, 25 Feb 2020 08:54:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=5MRTbwLPWhsz+OCfhc7KfndlpxpBjNwdciDoRgQ9Kiw=; b=UH81cZnwNAU0qj0U69UGyTcrTv
 s3U/2WEoUZteazt25hpIrP9mx2czSA73w1KKBo7jGQ2t7egu9fl8mN83EDjcSVbHFMPIlC0nz0jrE
 /sHO9tWieo1tWKMbYptvT/SEf3+uUhXvREH+sjpmBlq0Ix+GchDHn+n+UAer2XM6ls7irhVTLYsw4
 dfhQXNPHta9xRzxr9BLoaH+QyGz14ciyXbQ/Bf67V8Mwsvu0zvUzAj17rcatmJ0byo4OM++Tk9PJC
 fnSZ2gijdW6WE7VdnNAWYFBO6aYhYQh8JMyM4jVzhoj3AKirlrfCJSKYf4NtObVE2kjUhSCTXIPzv
 kIxJP4xQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j6LgY-0004om-8r; Mon, 24 Feb 2020 21:54:42 +0000
Date: Mon, 24 Feb 2020 13:54:42 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [Cluster-devel] [PATCH v7 13/24] fs: Convert mpage_readpages to
 mpage_readahead
Message-ID: <20200224215442.GB16051@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-14-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219210103.32400-14-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: cluster-devel@redhat.com, linux-ext4@vger.kernel.org, linux-mm@kvack.org,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 Junxiao Bi <junxiao.bi@oracle.com>, linux-xfs@vger.kernel.org,
 Joseph Qi <joseph.qi@linux.alibaba.com>, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-erofs@lists.ozlabs.org, ocfs2-devel@oss.oracle.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Feb 19, 2020 at 01:00:52PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Implement the new readahead aop and convert all callers (block_dev,
> exfat, ext2, fat, gfs2, hpfs, isofs, jfs, nilfs2, ocfs2, omfs, qnx6,
> reiserfs & udf).  The callers are all trivial except for GFS2 & OCFS2.

Looks sensible:

Reviewed-by: Christoph Hellwig <hch@lst.de>
