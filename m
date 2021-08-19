Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7DE3F1216
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Aug 2021 05:46:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GqrKR6k2Sz3bXS
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Aug 2021 13:46:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jyrL+b0D;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=jyrL+b0D; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GqrKN5jB6z307D
 for <linux-erofs@lists.ozlabs.org>; Thu, 19 Aug 2021 13:46:16 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0897B60F4C;
 Thu, 19 Aug 2021 03:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629344774;
 bh=0PWjpf7jKGNN5Wc86CUKn91Ytncf9Qqhm1wOt5aMf+I=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=jyrL+b0DzU+lE7vMa68BjDE/2NRLd8phHfQE3f6VYn/QR7k20sQ/nhxsU9HlP+6Rc
 Xq7LcA7EiG/+x7kWzh/xY+uGofQ8bYgDE4w9gJ4488+NSPn8HTQ08crMcfgx+qcGph
 BkBrgN3QGzIFiMC49NBemW6mp/jljeSx0/as8BB2jzv/E61EuceG0rZsBdX1jKyaFg
 Dvxlg8jXih9ctztWVDVvbqYmOo60CnPgJYfTeiSFiaKxn/CN/afaxljQiyaOcYYP0O
 ig0WXEFK6fyGHzpTbOW1YyaA3CWUZnO0wcVxS8x7JleTelk7XykqcPbbzAY+Wwy2kx
 ODlwL0qPywDwQ==
Subject: Re: [PATCH 2/2] erofs: support reading chunk-based uncompressed files
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 Liu Bo <bo.liu@linux.alibaba.com>
References: <20210818070713.4437-1-hsiangkao@linux.alibaba.com>
 <20210818070713.4437-2-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <2c833d7e-9f82-f1f7-a576-b9fc50e0cb15@kernel.org>
Date: Thu, 19 Aug 2021 11:46:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818070713.4437-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>,
 Eryu Guan <eguan@linux.alibaba.com>, Liu Jiang <gerry@linux.alibaba.com>,
 LKML <linux-kernel@vger.kernel.org>, Peng Tao <tao.peng@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/8/18 15:07, Gao Xiang wrote:
> +		else if (vi->datalayout == EROFS_INODE_CHUNK_BASED)
> +			/* fill chunked inode summary info */
> +			vi->chunkformat = __le16_to_cpu(die->i_u.c.format);

le16_to_cpu(),

>   		kfree(copied);
>   		break;
>   	case EROFS_INODE_LAYOUT_COMPACT:
> @@ -160,6 +163,8 @@ static struct page *erofs_read_inode(struct inode *inode,
>   		inode->i_size = le32_to_cpu(dic->i_size);
>   		if (erofs_inode_is_data_compressed(vi->datalayout))
>   			nblks = le32_to_cpu(dic->i_u.compressed_blocks);
> +		else if (vi->datalayout == EROFS_INODE_CHUNK_BASED)
> +			vi->chunkformat = __le16_to_cpu(dic->i_u.c.format);

Ditto.

Thanks,
