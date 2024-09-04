Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FBE96B22D
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Sep 2024 08:56:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WzCvS6dnNz2yRD
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Sep 2024 16:56:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725432978;
	cv=none; b=ZUrxM/bv1J99X0venXk1ti/bWo7K3SQ/1k7wvjPpU9BADWFq5VPOq64C/xZgvcuU+11QOzo4pKOtWPzTW/HamPJIsfjUFWX2vIKArzb+FZqqY7meCdrifsooZrmqb8/HZFwQOzjNhnJZImFmrDJP1j4beYd85cp52Cxni36jK5HWOeU1ALi5cNpw7c5VRfaoQaMhzMJe8x12cJA8aIz6MH3THTq+jAye21+HCIIDR9OkNoD8eGL4RqspzJPP0MqzqQdi7xH099T1zrPLh62egFexm0lI9hU7/6YNIFoD23DvX13Zc2MZqMvVDKm4kHcFiPWvjKY8SaybeDTKh9q7fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725432978; c=relaxed/relaxed;
	bh=74Yfbt5V1bRHHf2JB/mJ5iQAdMROQNunrC5fjEZ61Pg=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type; b=dWq/BfmBgM5sU/EwGa3Heui8q8K3zKflJVYOPdjHkKdHBUVFQWC0UDiQx6kOS3+kHbz5LCx8agH1gFS72ihY/JAQAbANqertCIRof8WOradwBy+esWBZqiELyhZxm3irLdpSAUoxdb3Py3ugQ1DtBue1QxLO+uQjWfdXtbQ1t2iKsas1+fN3gWq7JsHW6jhjhqooC1HK5UdF8hkl3K4GTfGiowNL9lZ3Fut1N8MaSuQ+fgg20mrPiEDW7y3yX4ux83ZRvyqvjt0/gN4AtvrmsbvXkQGdrmNlAA3mL/IpoU4pyPPkn0aiKxpXedP8V3x0TE4uYjBCJSZ56KRDjy0ZUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=N4Oouf9F; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=N4Oouf9F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WzCvP1RBdz2xPL
	for <linux-erofs@lists.ozlabs.org>; Wed,  4 Sep 2024 16:56:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725432970; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=74Yfbt5V1bRHHf2JB/mJ5iQAdMROQNunrC5fjEZ61Pg=;
	b=N4Oouf9FdcQuVPxCEb1pfPEsTjzFlB+lbAfSshabVW21hxNs9xglArt2A2Yufm09GkF1bUsNjC15wdEWUV5wZeaiOKr2g5wp8UunYiZKci7nJTgCqVyIJx7hVEljJfVtGNb0B2cOrK1kwGqVZPuQdBNyP6nKI2FXz9wtMuRrIi0=
Received: from 30.221.130.127(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEGOD2h_1725432968)
          by smtp.aliyun-inc.com;
          Wed, 04 Sep 2024 14:56:09 +0800
Message-ID: <443a883e-7565-43ed-9def-77e0d666c454@linux.alibaba.com>
Date: Wed, 4 Sep 2024 14:56:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] erofs: support unencoded inodes for fileio
To: linux-erofs@lists.ozlabs.org
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
 <20240830032840.3783206-2-hsiangkao@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240830032840.3783206-2-hsiangkao@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/8/30 11:28, Gao Xiang wrote:
> Since EROFS only needs to handle read requests in simple contexts,
> Just directly use vfs_iocb_iter_read() for data I/Os.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Unmapped extent could actually split, already fixed as below:

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index 598b865ae25f..7f82238047e6 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -127,6 +127,7 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
  			erofs_put_metabuf(&buf);
  		} else if (!(map->m_flags & EROFS_MAP_MAPPED)) {
  			folio_zero_segment(folio, cur, cur + len);
+			attached = 0;
  		} else {
  			if (io->rq && (map->m_pa + ofs != io->dev.m_pa ||
  				       map->m_deviceid != io->dev.m_deviceid)) {
