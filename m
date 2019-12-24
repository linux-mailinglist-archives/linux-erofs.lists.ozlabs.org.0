Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB47129FF4
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Dec 2019 11:05:51 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47hsL45sLpzDqMN
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Dec 2019 21:05:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47hsKz6lMhzDqKr
 for <linux-erofs@lists.ozlabs.org>; Tue, 24 Dec 2019 21:05:39 +1100 (AEDT)
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 84E48F39276A355A652B
 for <linux-erofs@lists.ozlabs.org>; Tue, 24 Dec 2019 18:05:28 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 24 Dec 2019 18:05:28 +0800
Received: from architecture4 (10.160.196.180) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 24 Dec 2019 18:05:27 +0800
Date: Tue, 24 Dec 2019 18:05:11 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [RFCv2] erofs-utils:code for detecting and tracking holes in
 uncompressed sparse files.
Message-ID: <20191224100511.GB164058@architecture4>
References: <20191223172938.13189-1-pratikshinde320@gmail.com>
 <20191224034817.GA164058@architecture4>
 <CAGu0czSu81J3UsdUKvGKed_XXDV5ipZB8qz83+cDPx_ZB4-R1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAGu0czSu81J3UsdUKvGKed_XXDV5ipZB8qz83+cDPx_ZB4-R1g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.160.196.180]
X-ClientProxiedBy: dggeme712-chm.china.huawei.com (10.1.199.108) To
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
Cc: miaoxie@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Pratik,

On Tue, Dec 24, 2019 at 03:05:53PM +0530, Pratik Shinde wrote:
> Hello Gao,
> 
> Thanks for the review.
> If I understand correctly , you wish to keep track of every extent assigned
> to the file.
> in case of file without any holes in it, there will single extent
> representing the entire file.
> 
> Also, the current block no. lookup happens in constant time. (since we only
> record the start blk no.)
> If we use extent record for finding given block no. it can't be done in
> constant time correct ? (maybe in LogN)


Could I ask a question?
In short, how can we use the proposal approach to read random blocks
in constant time O(1)?

e.g.
 if you have two holes 2...4  7...10 in a file with 12 blocks.

 if we want to random access block 11, only block number 1,5,6,11 were
 saved one by one (maybe p1,p2,p3,p4).

 How can we get the physical address (p4) of block 11 directly without
 scanning the previous holes?

Thanks,
Gao Xiang


> 
> I think I don't fully understand reason for recording extents assigned to a
> file.Since the current design
> is already time and space optimized & there are no deletions happening.
> Is it for some future requirement ?
> 
> --Pratik.

