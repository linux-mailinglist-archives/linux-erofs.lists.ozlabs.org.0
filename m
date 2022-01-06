Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2A64867CA
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jan 2022 17:41:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JVBv73sVpz30Ds
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Jan 2022 03:41:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JVBv12BP2z2yNW
 for <linux-erofs@lists.ozlabs.org>; Fri,  7 Jan 2022 03:41:14 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=9; SR=0; TI=SMTPD_---0V174cBl_1641487253; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V174cBl_1641487253) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 07 Jan 2022 00:40:55 +0800
Date: Fri, 7 Jan 2022 00:40:52 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 3/5] erofs: use meta buffers for super operations
Message-ID: <YdcblD+C9DE0K/Tm@B-P7TQMD6M-0146.local>
References: <20211229041405.45921-4-hsiangkao@linux.alibaba.com>
 <202112310650.TDDinvVT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202112310650.TDDinvVT-lkp@intel.com>
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
Cc: kbuild-all@lists.01.org, lkp@intel.com, kbuild@lists.01.org,
 Chao Yu <yuchao0@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 Liu Bo <bo.liu@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Dan,

On Thu, Jan 06, 2022 at 06:08:48PM +0300, Dan Carpenter wrote:
> Hi Gao,
> 
> url:    https://github.com/0day-ci/linux/commits/Gao-Xiang/erofs-get-rid-of-erofs_get_meta_page/20211229-121538
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
> config: x86_64-randconfig-m001-20211230 (https://download.01.org/0day-ci/archive/20211231/202112310650.TDDinvVT-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> fs/erofs/super.c:153 erofs_read_metadata() warn: possible memory leak of 'buffer'

Many thanks for the report.

It has already been fixed in the latest version:
https://lore.kernel.org/all/20220102081317.109797-1-hsiangkao@linux.alibaba.com/

(I've pushed out to the linux-next...)

Thanks,
Gao Xiang
