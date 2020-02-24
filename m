Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DDC16B305
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Feb 2020 22:44:00 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48RFv13JtPzDqSL
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Feb 2020 08:43:57 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=WER6q6aM; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48RFtv2vDLzDqL5
 for <linux-erofs@lists.ozlabs.org>; Tue, 25 Feb 2020 08:43:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
 :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=IBmpdg54DdbeZAoJdfQydcGyDg8H1e/FIpFw/vfYtE4=; b=WER6q6aMIxiEGc+j/HGcg87kgh
 fzNH5dUAX47ArvTEcqOgiOSjadyzvjYxi7Z+MNemow4AoVsB97AsbXwMFCWorXOXLyW4/Bi/1vxFR
 pekPIkO1XBmskg8wIjbG1r89NfDd26q/hqyfaI2g/8EolO9JVp55Al1+R5Mb9Co/yj7iles1i8y0+
 Ogbq4hrGehMtbChyDWTVLnLZK/CEUdmMF6F7w+67mUpRFsUbz1BetpuyOeDRb0R9UTQUnw/MfxN4t
 On18RaxEjiVcVeDM/VtvaYZgSM8WH7HCFrdX8QnSdbWbJyOTtLdDJc38/NHqwAQoFYGr30to44pf+
 HaIFogKQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j6LVz-0007sB-AO; Mon, 24 Feb 2020 21:43:47 +0000
Date: Mon, 24 Feb 2020 13:43:47 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v7 14/24] btrfs: Convert from readpages to readahead
Message-ID: <20200224214347.GH13895@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-15-willy@infradead.org>
 <SN4PR0401MB35987D7B76007B93B1C5CE5E9B130@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200220134849.GV24185@bombadil.infradead.org>
 <20200220154658.GA19577@infradead.org>
 <20200220155452.GX24185@bombadil.infradead.org>
 <20200220155727.GA32232@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200220155727.GA32232@infradead.org>
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
Cc: "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 Christoph Hellwig <hch@infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Feb 20, 2020 at 07:57:27AM -0800, Christoph Hellwig wrote:
> On Thu, Feb 20, 2020 at 07:54:52AM -0800, Matthew Wilcox wrote:
> > On Thu, Feb 20, 2020 at 07:46:58AM -0800, Christoph Hellwig wrote:
> > > On Thu, Feb 20, 2020 at 05:48:49AM -0800, Matthew Wilcox wrote:
> > > > btrfs: Convert from readpages to readahead
> > > >   
> > > > Implement the new readahead method in btrfs.  Add a readahead_page_batch()
> > > > to optimise fetching a batch of pages at once.
> > > 
> > > Shouldn't this readahead_page_batch heper go into a separate patch so
> > > that it clearly stands out?
> > 
> > I'll move it into 'Put readahead pages in cache earlier' for v8 (the
> > same patch where we add readahead_page())
> 
> One argument for keeping it in a patch of its own is that btrfs appears
> to be the only user, and Goldwyn has a WIP conversion of btrfs to iomap,
> so it might go away pretty soon and we could just revert the commit.
> 
> But this starts to get into really minor details, so I'll shut up now :)

So looking at this again I have another comment and a question.

First I think the implicit ARRAY_SIZE in readahead_page_batch is highly
dangerous, as it will do the wrong thing when passing a pointer or
function argument.

Second I wonder іf it would be worth to also switch to a batched
operation in iomap if the xarray overhead is high enough.  That should
be pretty trivial, but we don't really need to do it in this series.
