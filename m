Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2FE16B34B
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Feb 2020 22:54:28 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48RG7553MQzDqT1
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Feb 2020 08:54:25 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=k4YHtYQM; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48RG6y42B7zDqSK
 for <linux-erofs@lists.ozlabs.org>; Tue, 25 Feb 2020 08:54:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
 :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=APtxhiGX2oo2NuFWECGVLQtSqhQUVX091Swo9E3jyGQ=; b=k4YHtYQMII9XuUXNa7K98f5Lr8
 8kxvJ/tzbiUBK0u8QPQlhc0S7pbYmtD+Kp/ADfY06g04+syMs0jiIxgreUVqaL2jTdxfVFgmvRJIq
 oTmznOvFRzH5WSEJ9IWPTFDJ+erRAgDrH/RmPUBzK601Fwa6IdIoQ6C3fegnBHogmdc5w+2qvj5gY
 azQCmdMraUIHucXS6vJTgsz3Fe5JuP/OkXHWU/LXgR0E4YJ9UfZD+tC1vsf+PL62iedbWaYajeqcO
 g6/F6Ohsx0R3d7CnbruJ/vQynXFS4X6INJIgfA7SRCec91PJ4VA+gJ2wESYF19FEGFB+fvp/elqYF
 ZWBJCgSg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j6Lg6-0004ll-A1; Mon, 24 Feb 2020 21:54:14 +0000
Date: Mon, 24 Feb 2020 13:54:14 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v7 14/24] btrfs: Convert from readpages to readahead
Message-ID: <20200224215414.GR24185@bombadil.infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-15-willy@infradead.org>
 <SN4PR0401MB35987D7B76007B93B1C5CE5E9B130@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200220134849.GV24185@bombadil.infradead.org>
 <20200220154658.GA19577@infradead.org>
 <20200220155452.GX24185@bombadil.infradead.org>
 <20200220155727.GA32232@infradead.org>
 <20200224214347.GH13895@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200224214347.GH13895@infradead.org>
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

On Mon, Feb 24, 2020 at 01:43:47PM -0800, Christoph Hellwig wrote:
> On Thu, Feb 20, 2020 at 07:57:27AM -0800, Christoph Hellwig wrote:
> > On Thu, Feb 20, 2020 at 07:54:52AM -0800, Matthew Wilcox wrote:
> > > On Thu, Feb 20, 2020 at 07:46:58AM -0800, Christoph Hellwig wrote:
> > > > On Thu, Feb 20, 2020 at 05:48:49AM -0800, Matthew Wilcox wrote:
> > > > > btrfs: Convert from readpages to readahead
> > > > >   
> > > > > Implement the new readahead method in btrfs.  Add a readahead_page_batch()
> > > > > to optimise fetching a batch of pages at once.
> > > > 
> > > > Shouldn't this readahead_page_batch heper go into a separate patch so
> > > > that it clearly stands out?
> > > 
> > > I'll move it into 'Put readahead pages in cache earlier' for v8 (the
> > > same patch where we add readahead_page())
> > 
> > One argument for keeping it in a patch of its own is that btrfs appears
> > to be the only user, and Goldwyn has a WIP conversion of btrfs to iomap,
> > so it might go away pretty soon and we could just revert the commit.
> > 
> > But this starts to get into really minor details, so I'll shut up now :)
> 
> So looking at this again I have another comment and a question.
> 
> First I think the implicit ARRAY_SIZE in readahead_page_batch is highly
> dangerous, as it will do the wrong thing when passing a pointer or
> function argument.

somebody already thought of that ;-)

#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))

> Second I wonder іf it would be worth to also switch to a batched
> operation in iomap if the xarray overhead is high enough.  That should
> be pretty trivial, but we don't really need to do it in this series.

I've also considered keeping a small array of pointers inside the
readahead_control so nobody needs to have a readahead_page_batch()
operation.  Even keeping 10 pointers in there will reduce the XArray
overhead by 90%.  But this fit the current btrfs model well, and it
lets us play with different approaches by abstracting everything away.
I'm sure this won't be the last patch that touches the readahead code ;-)
