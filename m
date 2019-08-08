Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB5785CA6
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Aug 2019 10:18:08 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4641TT3tR9zDqML
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Aug 2019 18:18:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=fromorbit.com
 (client-ip=211.29.132.246; helo=mail104.syd.optusnet.com.au;
 envelope-from=david@fromorbit.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=fromorbit.com
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au
 [211.29.132.246])
 by lists.ozlabs.org (Postfix) with ESMTP id 4641TK5KjyzDqKl
 for <linux-erofs@lists.ozlabs.org>; Thu,  8 Aug 2019 18:17:56 +1000 (AEST)
Received: from dread.disaster.area (pa49-181-167-148.pa.nsw.optusnet.com.au
 [49.181.167.148])
 by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 2411843E618;
 Thu,  8 Aug 2019 18:17:54 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
 (envelope-from <david@fromorbit.com>)
 id 1hvdbL-0001Bg-NE; Thu, 08 Aug 2019 18:16:47 +1000
Date: Thu, 8 Aug 2019 18:16:47 +1000
From: Dave Chinner <david@fromorbit.com>
To: Gao Xiang <gaoxiang25@huawei.com>,
 Goldwyn Rodrigues <RGoldwyn@suse.com>, "hch@lst.de" <hch@lst.de>,
 "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "ruansy.fnst@cn.fujitsu.com" <ruansy.fnst@cn.fujitsu.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 linux-erofs@lists.ozlabs.org, miaoxie@huawei.com
Subject: Re: [PATCH 10/13] iomap: use a function pointer for dio submits
Message-ID: <20190808081647.GI7689@dread.disaster.area>
References: <20190802220048.16142-1-rgoldwyn@suse.de>
 <20190802220048.16142-11-rgoldwyn@suse.de>
 <20190804234321.GC7689@dread.disaster.area>
 <1565021323.13240.14.camel@suse.com>
 <20190805215458.GH7689@dread.disaster.area>
 <20190808042640.GA28630@138>
 <20190808054936.GA5319@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808054936.GA5319@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
 a=gu9DDhuZhshYSb5Zs/lkOA==:117 a=gu9DDhuZhshYSb5Zs/lkOA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
 a=7-415B0cAAAA:8 a=TBOsBtRu_f-vuJ8yFLgA:9 a=CjuIK1q_8ugA:10
 a=biEYGPWJfzWAr4FL6Ov7:22
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Aug 07, 2019 at 10:49:36PM -0700, Eric Biggers wrote:
> FWIW, the only order that actually makes sense is decrypt->decompress->verity.

*nod*

Especially once we get the inline encryption support for fscrypt so
the storage layer can offload the encrypt/decrypt to hardware via
the bio containing plaintext. That pretty much forces fscrypt to be
the lowest layer of the filesystem transformation stack.  This
hardware offload capability also places lots of limits on what you
can do with block-based verity layers below the filesystem. e.g.
using dm-verity when you don't know if there's hardware encryption
below or software encryption on top becomes problematic...

So really, from a filesystem and iomap perspective, What Eric says
is the right - it's the only order that makes sense...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
