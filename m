Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 093434E49B
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2019 11:51:11 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45VYq03G9rzDqd7
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2019 19:51:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.32; helo=huawei.com; envelope-from=yuchao0@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45VYpw4PFMzDqYB
 for <linux-erofs@lists.ozlabs.org>; Fri, 21 Jun 2019 19:51:04 +1000 (AEST)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 20A01448ADF50FCA3AE8;
 Fri, 21 Jun 2019 17:51:01 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 21 Jun
 2019 17:50:52 +0800
Subject: Re: [PATCH v2 6/8] staging: erofs: introduce LZ4 decompression inplace
To: Gao Xiang <gaoxiang25@huawei.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
References: <20190620160719.240682-1-gaoxiang25@huawei.com>
 <20190620160719.240682-7-gaoxiang25@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <bf1ebb0f-3039-d7d1-95cd-f49cadd6085e@huawei.com>
Date: Fri, 21 Jun 2019 17:50:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190620160719.240682-7-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
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
Cc: devel@driverdev.osuosl.org, Miao Xie <miaoxie@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>, Du Wei <weidu.du@huawei.com>,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2019/6/21 0:07, Gao Xiang wrote:
> compressed data will be usually loaded into last pages of
> the extent (the last page for 4k) for in-place decompression
> (more specifically, in-place IO), as ilustration below,
> 
>          start of compressed logical extent
>            |                          end of this logical extent
>            |                           |
>      ______v___________________________v________
> ... |  page 6  |  page 7  |  page 8  |  page 9  | ...
>     |__________|__________|__________|__________|
>            .                         ^ .        ^
>            .                         |compressed|
>            .                         |   data   |
>            .                           .        .
>            |<          dstsize        >|<margin>|
>                                        oend     iend
>            op                        ip
> 
> Therefore, it's possible to do decompression inplace (thus no
> memcpy at all) if the margin is sufficient and safe enough [1],
> and it can be implemented only for fixed-size output compression
> compared with fixed-size input compression.
> 
> No memcpy for most of in-place IO (about 99% of enwik9) after
> decompression inplace is implemented and sequential read will
> be improved of course (see the following patches for test results).
> 
> [1] https://github.com/lz4/lz4/commit/b17f578a919b7e6b078cede2d52be29dd48c8e8c
>     https://github.com/lz4/lz4/commit/5997e139f53169fa3a1c1b4418d2452a90b01602
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>
