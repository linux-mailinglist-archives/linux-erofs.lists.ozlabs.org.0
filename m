Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF02177323
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Mar 2020 10:52:28 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48WskF6vP0zDqJC
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Mar 2020 20:52:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=yuchao0@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Wsgl0PdvzDqHp
 for <linux-erofs@lists.ozlabs.org>; Tue,  3 Mar 2020 20:50:10 +1100 (AEDT)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id AE1EDB7AAA038C916A33;
 Tue,  3 Mar 2020 17:50:04 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 3 Mar 2020
 17:49:55 +0800
Subject: Re: [PATCH 2/3] erofs: use LZ4_decompress_safe() for full decoding
To: Gao Xiang <gaoxiang25@huawei.com>, <linux-erofs@lists.ozlabs.org>
References: <20200226023011.103798-1-gaoxiang25@huawei.com>
 <20200226023011.103798-2-gaoxiang25@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <8c1a119e-7f3d-a42d-3208-d30b476baf73@huawei.com>
Date: Tue, 3 Mar 2020 17:49:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200226023011.103798-2-gaoxiang25@huawei.com>
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
Cc: Lasse Collin <lasse.collin@tukaani.org>, Miao Xie <miaoxie@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2020/2/26 10:30, Gao Xiang wrote:
> As Lasse pointed out, "EROFS uses LZ4_decompress_safe_partial
> for both partial and full blocks. Thus when it is decoding a
> full block, it doesn't know if the LZ4 decoder actually decoded
> all the input. The real uncompressed size could be bigger than
> the value stored in the file system metadata.
> 
> Using LZ4_decompress_safe instead of _safe_partial when
> decompressing a full block would help to detect errors."
> 
> So it's reasonable to use _safe in case of corrupted images and
> it might have some speed gain as well although I didn't observe
> much difference.
> 
> Cc: Lasse Collin <lasse.collin@tukaani.org>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
