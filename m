Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8739E55B
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Aug 2019 12:08:05 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Hl1Y6vsBzDqxh
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Aug 2019 20:08:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.255; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46HkzW0wJZzDqTl
 for <linux-erofs@lists.ozlabs.org>; Tue, 27 Aug 2019 20:06:14 +1000 (AEST)
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id B3149CC8D70EA1D8CA95;
 Tue, 27 Aug 2019 18:06:08 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 27 Aug 2019 18:06:08 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 27 Aug 2019 18:06:08 +0800
Date: Tue, 27 Aug 2019 18:05:23 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [bug report] staging: erofs: tidy up decompression frontend
Message-ID: <20190827100523.GA236561@architecture4>
References: <20190827090355.GA29280@mwanda>
 <20190827093629.GA55193@architecture4>
 <20190827095347.GN3964@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190827095347.GN3964@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme713-chm.china.huawei.com (10.1.199.109) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
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
Cc: xiang@kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Aug 27, 2019 at 12:53:47PM +0300, Dan Carpenter wrote:
> On Tue, Aug 27, 2019 at 05:36:29PM +0800, Gao Xiang wrote:
> > Hi Dan,
> > 
> > Thanks for your report.
> > 
> > On Tue, Aug 27, 2019 at 12:03:55PM +0300, Dan Carpenter wrote:
> > > Hello Gao Xiang,
> > > 
> > > This is a semi-automatic email about new static checker warnings.
> > > 
> > > The patch 97e86a858bc3: "staging: erofs: tidy up decompression
> > > frontend" from Jul 31, 2019, leads to the following Smatch complaint:
> > > 
> > >     fs/erofs/zdata.c:670 z_erofs_do_read_page()
> > >     error: we previously assumed 'clt->cl' could be null (see line 596)
> > > 
> > > fs/erofs/zdata.c
> > >    595			/* didn't get a valid collection previously (very rare) */
> > >    596			if (!clt->cl)
> > >                             ^^^^^^^^
> > > New NULL check.
> > > 
> > >    597				goto restart_now;
> > >    598			goto hitted;
> > >    599		}
> > >    600	
> > >    601		/* go ahead the next map_blocks */
> > >    602		debugln("%s: [out-of-range] pos %llu", __func__, offset + cur);
> > >    603	
> > >    604		if (z_erofs_collector_end(clt))
> > >    605			fe->backmost = false;
> > >    606	
> > >    607		map->m_la = offset + cur;
> > >    608		map->m_llen = 0;
> > >    609		err = z_erofs_map_blocks_iter(inode, map, 0);
> > >    610		if (unlikely(err))
> > >    611			goto err_out;
> > >    612	
> > >    613	restart_now:
> > >    614		if (unlikely(!(map->m_flags & EROFS_MAP_MAPPED)))
> > >    615			goto hitted;
> > >    616	
> > >    617		err = z_erofs_collector_begin(clt, inode, map);
> > 
> > At a glance, clt->cl will be all initialized in all successful paths
> > in z_erofs_collector_begin, or it all fall back into err_out...
> > I have no idea what is wrong here...
> > 
> > Some detailed path from Smatch for NIL dereferences?
> > 
> 
> Ah.  Sorry for that.  It's a false positive.  I will investigate and
> fix Smatch.

Yeah.. I was little confused, since this patch mostly renames many names...
and the main logic is unchanged for months... and for this case there are 2 paths...

 1) hit line 614 --> goto hitted --> hit line 633 --> goto next_part; (will skip line 670);
 2) hit line 617 --> go into z_erofs_collector_begin -->
    all successful paths will assign clt->cl, so clt->cl != NULL...

Though z_erofs_do_read_page is currently somewhat complicated (mostly due to some
historical fixes in order to backport friendly), I will simplify this function
in the later version (..and with care in case of introducing new bugs) :-)

Thanks,
Gao Xiang

> 
> regards,
> dan carpenter
> 
