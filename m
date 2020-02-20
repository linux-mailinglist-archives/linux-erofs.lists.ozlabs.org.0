Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8D9165F31
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Feb 2020 14:51:15 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48NbbP0MQTzDqJ7
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Feb 2020 00:51:13 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 48NbXn5tHDzDqWg
 for <linux-erofs@lists.ozlabs.org>; Fri, 21 Feb 2020 00:48:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=zBQV1Nvl6gQ7063nOMO4bl4Qit9dtUsePu9xZtdIUpM=; b=igtOB94RI8XKtzVTmpl7adfTBc
 nUPRfeBQAn6qgMu2mIMXdqdemGWBPZM6m1mk0JRQ4gln6YP021QrTz7JW7WriTW9kQd9HhefrWodr
 DPdZE7ea3rkTiKxZzjV2rfZFsVohFeCSeKjLKjW2laQNPicIuou8l8cd1nA0LgsCPlX64i0y7yahW
 32HPR3UOUNpTTE89QggDpsf9Uy+G746NO+E5c6nPo49C7MXOyuBpobo2jZnaHlZEfffwdWw5lxpdO
 LXm98qt8lqtRm5JiZBti5MLazqN7XkI5SW89icHM4E2rVuaoGC9UJqrtuJmXRDlbntv0SnHwa7P6h
 mNHva41Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j4mC9-0006TC-8A; Thu, 20 Feb 2020 13:48:49 +0000
Date: Thu, 20 Feb 2020 05:48:49 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v7 14/24] btrfs: Convert from readpages to readahead
Message-ID: <20200220134849.GV24185@bombadil.infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-15-willy@infradead.org>
 <SN4PR0401MB35987D7B76007B93B1C5CE5E9B130@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB35987D7B76007B93B1C5CE5E9B130@SN4PR0401MB3598.namprd04.prod.outlook.com>
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

On Thu, Feb 20, 2020 at 09:42:19AM +0000, Johannes Thumshirn wrote:
> On 19/02/2020 22:03, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > Use the new readahead operation in btrfs.  Add a
> > readahead_for_each_batch() iterator to optimise the loop in the XArray.
> 
> OK I must admit I haven't followed this series closely, but what 
> happened to said readahead_for_each_batch()?
> 
> As far as I can see it's now:
> 
> [...]
> > +	while ((nr = readahead_page_batch(rac, pagepool))) {

Oops, forgot to update the changelog there.  Yes, that's exactly what it
changed to.  That discussion was here:

https://lore.kernel.org/linux-fsdevel/20200219144117.GP24185@bombadil.infradead.org/

... and then Christoph pointed out the iterators weren't really adding
much value at that point, so they got deleted.  New changelog for
this patch:

btrfs: Convert from readpages to readahead
  
Implement the new readahead method in btrfs.  Add a readahead_page_batch()
to optimise fetching a batch of pages at once.

