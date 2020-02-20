Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id DD64A166181
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Feb 2020 16:55:02 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48NfLD12cyzDqWZ
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Feb 2020 02:55:00 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=PM/AprBi; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48NfL71Z69zDqV4
 for <linux-erofs@lists.ozlabs.org>; Fri, 21 Feb 2020 02:54:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=D6I8jW+2llttZsSrEwC7oLd5yfRbnmR5fQ3XY07h6/A=; b=PM/AprBicbU39edYsbWTpTc0Na
 emVcq7cb+NHUM6oooQNEoXkG8+bHD9DPrTjjG2z2x3T5qTsF2asVZBk11hr9EbGPUjnd00E3//wQZ
 Ybl+M5Ncbk5X+eqZuv5FQg2IiH2QMSkNvYYPTlkj7xTRE/LwRRrh6jsluV0sdP9tbDuj8LPcnDHs1
 hcDRVlsCikcg/+gbg3xn8+BGR6mA7HS7wgpHnbqj5ErHAFq/eFM9zwR+c5djfNPqtTIEOm8KczQWy
 Y9fVsWdlNqjO9NJrXN3ek4kvMofOELyh95VqWLxea4QhQIGt2c5AYVzLVexEyX6ylz0YB4RkWIKLh
 T/R9auvw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j4oA8-00077l-7Q; Thu, 20 Feb 2020 15:54:52 +0000
Date: Thu, 20 Feb 2020 07:54:52 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v7 14/24] btrfs: Convert from readpages to readahead
Message-ID: <20200220155452.GX24185@bombadil.infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-15-willy@infradead.org>
 <SN4PR0401MB35987D7B76007B93B1C5CE5E9B130@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200220134849.GV24185@bombadil.infradead.org>
 <20200220154658.GA19577@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220154658.GA19577@infradead.org>
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
Cc: "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Feb 20, 2020 at 07:46:58AM -0800, Christoph Hellwig wrote:
> On Thu, Feb 20, 2020 at 05:48:49AM -0800, Matthew Wilcox wrote:
> > btrfs: Convert from readpages to readahead
> >   
> > Implement the new readahead method in btrfs.  Add a readahead_page_batch()
> > to optimise fetching a batch of pages at once.
> 
> Shouldn't this readahead_page_batch heper go into a separate patch so
> that it clearly stands out?

I'll move it into 'Put readahead pages in cache earlier' for v8 (the
same patch where we add readahead_page())
