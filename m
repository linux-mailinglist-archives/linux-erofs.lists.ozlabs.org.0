Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B5072277F
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Jun 2023 15:34:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QZZMq4l7Pz3f0R
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Jun 2023 23:34:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QZZMk6dr3z3bxL
	for <linux-erofs@lists.ozlabs.org>; Mon,  5 Jun 2023 23:34:25 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VkSJYY3_1685972058;
Received: from 192.168.3.7(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VkSJYY3_1685972058)
          by smtp.aliyun-inc.com;
          Mon, 05 Jun 2023 21:34:19 +0800
Message-ID: <ddc2484b-e45c-20ef-853d-745e5f287055@linux.alibaba.com>
Date: Mon, 5 Jun 2023 21:34:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] erofs-utils: fsck: fix segmentation fault for file
 extraction
To: Guo Xuenan <guoxuenan@huawei.com>, chao@kernel.org,
 linux-erofs@lists.ozlabs.org
References: <20230605125815.2835732-1-guoxuenan@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230605125815.2835732-1-guoxuenan@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: jack.qiu@huawei.com, yangchaoming666@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/6/5 20:58, Guo Xuenan via Linux-erofs wrote:
> Currently, we use fsckcfg.extract_path to record the path of file
> to be extracted, when the name is too long, it will exceed the
> fsckcfg.extract_path[PATH_MAX] array and segmentation fault may
> occur.
> 
> Test and reproduce with the following script:
> ``` bash
> #!/bin/bash
> FSCK=`which fsck.erofs`
> MKFS=`which mkfs.erofs`
> 
> IN_DIR=./src
> $MKFS x.img ${IN_DIR}
> 
> get_dst_dir()
> {
> 	local len=$1
> 	local perlen=$2
> 	local dst_dir=$(printf 'a%.0s' $(seq 1 $((perlen - 1))))
> 	local n=$((len / ${perlen}))
> 	local lastlen=$((len - perlen * n))
> 	local lastdir=$(printf 'a%.0s' $(seq 1 $lastlen))
> 	local outdir=""
> 	for x in `seq 1 $n`
> 	do
> 		outdir=${outdir}/${dst_dir}
> 	done
> 
> 	[[ -n $lastdir ]] && outdir=${outdir}/${lastdir}
> 	echo ${outdir}
> }
> 
> for n in `seq 4000 1 5000`
> do
> 	dst_dir=$(get_dst_dir $n 255)
> 	echo ${#dst_dir}
> 
> 	OUT_DIR="./${dst_dir}"
> 	rm -rf $(dirname $OUT_DIR) > /dev/null 2>&1
> 	mkdir -p $OUT_DIR
> 	$FSCK --extract=${OUT_DIR} x.img > /dev/null 2>&1
> done
> ```
> 
> Fixes: f44043561491 ("erofs-utils: introduce fsck.erofs")
> Fixes: b11f84f593f9 ("erofs-utils: fsck: convert to use erofs_iterate_dir()")
> Fixes: 412c8f908132 ("erofs-utils: fsck: add --extract=X support to extract to path X")
> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
