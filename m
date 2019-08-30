Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DAEA3CB6
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 18:56:00 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Klws5NYrzDqlR
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Aug 2019 02:55:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+b0e6514120785512acaa+5850+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="h3Hti2HJ"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Klwm4DlPzDqRY
 for <linux-erofs@lists.ozlabs.org>; Sat, 31 Aug 2019 02:55:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5tlZ2AJFJvBfkQ9+HB/A14V0Nr0ngU+sXRXPgXv+PBY=; b=h3Hti2HJW1XQj8WFYW5QPnxq3
 IFR5kBbNPZGUfJLZgkmP05rpU8kdnbpvD+FGCox/WaA3veCbBUk14Fo8QDppOCOnKanexpTcCpiIC
 sE6OdPzOcn3dr2hQ3CHqWtqGye3D73Fhvq0Q17vVPtbBGqh/n5zn/4vnANjKz08CE7A/cFoQUGoK+
 QAYOlb7eXFJYXO9Z2QKijMU6akEztn+q/Y5JPZP/3q07D2/M04Fi6WwQDEhKWs29h7U3KXFx3H23K
 us6o/usVO3kjrh5OHnBglnCka42lTRpqePeoTQmgPzOXE/Zj/25p3KVTeSiYirbxV1MnU40j6IPKo
 dF4fbKs+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1i3kBR-00045V-TF; Fri, 30 Aug 2019 16:55:33 +0000
Date: Fri, 30 Aug 2019 09:55:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH v8 20/24] erofs: introduce generic decompression backend
Message-ID: <20190830165533.GA10909@infradead.org>
References: <20190815044155.88483-1-gaoxiang25@huawei.com>
 <20190815044155.88483-21-gaoxiang25@huawei.com>
 <20190830163534.GA29603@infradead.org>
 <20190830165217.GB107220@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830165217.GB107220@architecture4>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Cc: Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
 David Sterba <dsterba@suse.cz>, Miao Xie <miaoxie@huawei.com>,
 devel@driverdev.osuosl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 "Darrick J . Wong" <darrick.wong@oracle.com>,
 Richard Weinberger <richard@nod.at>, Christoph Hellwig <hch@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Amir Goldstein <amir73il@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@denx.de>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Aug 31, 2019 at 12:52:17AM +0800, Gao Xiang wrote:
> Hi Christoph,
> 
> On Fri, Aug 30, 2019 at 09:35:34AM -0700, Christoph Hellwig wrote:
> > On Thu, Aug 15, 2019 at 12:41:51PM +0800, Gao Xiang wrote:
> > > +static bool use_vmap;
> > > +module_param(use_vmap, bool, 0444);
> > > +MODULE_PARM_DESC(use_vmap, "Use vmap() instead of vm_map_ram() (default 0)");
> > 
> > And how would anyone know which to pick?
> 
> It has significant FIO benchmark difference on sequential read least on arm64...
> I have no idea whether all platform vm_map_ram() behaves better than vmap(),
> so I leave an option for users here...

vm_map_ram is supposed to generally behave better.  So if it doesn't
please report that that to the arch maintainer and linux-mm so that
they can look into the issue.  Having user make choices of deep down
kernel internals is just a horrible interface.

Please talk to maintainers of other bits of the kernel if you see issues
and / or need enhancements.
