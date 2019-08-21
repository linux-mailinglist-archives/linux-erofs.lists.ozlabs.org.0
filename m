Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F5B96F0D
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2019 03:51:26 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46CrHH3QLszDrMC
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2019 11:51:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=156.151.31.86; helo=userp2130.oracle.com;
 envelope-from=darrick.wong@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="FDvr2ftW"; 
 dkim-atps=neutral
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46CrDw5skNzDr9j
 for <linux-erofs@lists.ozlabs.org>; Wed, 21 Aug 2019 11:49:20 +1000 (AEST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7L1maqI195217;
 Wed, 21 Aug 2019 01:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=X9xsyFLEY3yP4I676i8c4HP6MyP9BTNfKYIf1szA01g=;
 b=FDvr2ftWIxB85iRzNRLX28ilXAxY2wJDdWiEmq2fe9iT7rmrVElxprVWE3C5+XdZc6qC
 U/iqsoHuNOLrYhpmMmJUEPNonvgADpoomNLODoeYqn6yfMrz7SRu43ruFUJ7cMCTeoyQ
 IfeJd/KbLMa49UoE49T9PsGKpmqmHjcgTv2/Ayx4SVQEafcaSeGLoFqUWQwNBGp0b0Gy
 8aLSXJr/bOWkdMMhPy+pwq04FtpOV9dh10pTmayXhVSM3jVDjz8+pp2eRxhXwrpWpZy7
 3lzAKXsZgg9i+fRePnrjMuHFJwPdsIQRAJrE5g7oswzwcPRIHwwgK2ZnYedcf7SB7pds 3w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2ue90tj9fx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Aug 2019 01:48:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7L1lUY3193680;
 Wed, 21 Aug 2019 01:48:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 2ug269de77-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Aug 2019 01:48:35 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7L1mLEr028154;
 Wed, 21 Aug 2019 01:48:21 GMT
Received: from localhost (/10.159.156.31)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 20 Aug 2019 18:48:21 -0700
Date: Tue, 20 Aug 2019 18:48:18 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] erofs: move erofs out of staging
Message-ID: <20190821014818.GB1037422@magnolia>
References: <20190818172938.GA14413@sol.localdomain>
 <20190818174702.GA17633@infradead.org>
 <20190818181654.GA1617@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190818201405.GA27398@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190819160923.GG15198@magnolia>
 <20190819203051.GA10075@hsiangkao-HP-ZHAN-66-Pro-G1>
 <bdb91cbf-985b-5a2c-6019-560b79739431@gmx.com>
 <ad62636f-ef1b-739f-42cc-28d9d7ed86da@huawei.com>
 <20190820155623.GA10232@mit.edu>
 <9d8f88ee-4b81-bdfa-b0d7-9c7d5d54e70a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d8f88ee-4b81-bdfa-b0d7-9c7d5d54e70a@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908210015
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908210015
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
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
 Amir Goldstein <amir73il@gmail.com>, Dave Chinner <david@fromorbit.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
 devel <devel@driverdev.osuosl.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Richard Weinberger <richard@nod.at>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Eric Biggers <ebiggers@kernel.org>, torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 "Theodore Y. Ts'o" <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
 David Sterba <dsterba@suse.cz>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-erofs <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Aug 21, 2019 at 09:34:02AM +0800, Chao Yu wrote:
> On 2019/8/20 23:56, Theodore Y. Ts'o wrote:
> > The reason why there needs to be at least some file system specific
> > code for fuzz testing is because for efficiency's sake, you don't want
> > to fuzz every single bit in the file system, but just the ones which
> > are most interesting (e.g., the metadata blocks).  For file systems
> > which use checksum to protect against accidental corruption, the file
> > system fuzzer needs to also fix up the checksums (since you can be
> > sure malicious attackers will do this).
> 
> Yup, IMO, if we really want such tool, it needs to:
> - move all generic fuzz codes (trigger random fuzzing in meta/data area) into
> that tool, and
> - make filesystem generic fs_meta/file_node lookup/inject/pack function as a
> callback, such as
>  * .find_fs_sb
>  * .inject_fs_sb
>  * .pack_fs_sb

What about group descriptors?  AG headers?  The AGFLWTFBBQLOL?

>  * .find_fs_bitmap
>  * .inject_fs_bitmap

Probably want an find/inject for log blocks too.

Oh, wait, XFS doesn't log blocks like jbd2 does. :) :)

>  * .find_fs_inode_bitmap
>  * .inject_fs_inode_bitmap

XFS has an inode bitmap? ;)

(This is why there's no generic fuzz tool; every fs is different enough
that doing so would be sort of a mess.)

((Granted, you could also look at how xfstests uses the xfs_db fuzz
command so at least it would be systematic...))

>  * .find_inode_by_num
>  * .inject_inode
>  * .pack_inode
>  * .find_tree_node_by_level
> ...

What about the name/value btrees?  (Ok, I'll stop now.)

--D

> then specific filesystem can fill the callback to tell how the tool can locate a
> field in inode or a metadata in tree node and then trigger the designed fuzz.
> 
> It will be easier to rewrite whole generic fwk for each filesystem, because
> existed filesystem userspace tool should has included above callback's detail
> codes...
> 
> > On Tue, Aug 20, 2019 at 10:24:11AM +0800, Chao Yu wrote:
> >> filesystem fill the tool's callback to seek a node/block and supported fields
> >> can be fuzzed in inode.
> 
> > 
> > What you *can* do is to make the file system specific portion of the
> > work as small as possible.  Great work in this area is Professor Kim's
> > Janus[1][2] and Hydra[2] work.  (Hydra is about to be published at SOSP 19,
> > and was partially funded from a Google Faculty Research Work.)
> > 
> > [1] https://taesoo.kim/pubs/2019/xu:janus.pdf
> > [2] https://github.com/sslab-gatech/janus
> > [3] https://github.com/sslab-gatech/hydra
> 
> Thanks for the information!
> 
> It looks like janus and hydra alreay have generic compress/decompress function
> across different filesystems, it's really a good job, I do think it may be the
> one once it becomes more generic.
> 
> Thanks
> 
> > 
