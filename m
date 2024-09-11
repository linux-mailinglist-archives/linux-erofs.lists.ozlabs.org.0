Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F52974DDF
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Sep 2024 11:04:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X3ZQ72kcmz2ym2
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Sep 2024 19:04:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726045469;
	cv=none; b=Y74ErD97YjhU1kSnXMROX/wGpYmkeyuHhbhA5q07HsOdOM1iAQHz2X4r2eKRRR3qdHY9x5uUIGZyCqlFS77GA1M4sfCrW0upaxp//8LCQd3mjy+vDIRrhDD/x5FlMSWI8aU3onyXL9X+aLuvW6u7g/m00B06bPYirqBT39aX8lsXWtP6UBKpEKv5RcqdtoBUejwElQaemXl3b26LW2tTIePDX/wiJa2Ylq4uQymDenngztHPMTOmPugfhj4dpD1BtVp8vOlVqEd2GZe8DbseJMVWPX7DTlQkx5tOJPBbs4/aBXbOBdgdYCxYr7HcdRspP1F9uYj+qys7Jyj7JJP4jg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726045469; c=relaxed/relaxed;
	bh=cQjbKqN2Va0/LLOZRFXrPPQKrj6uag96SglvKYLhG3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X2UIxJ2ZciwsvzfVz60N3wbuHPFPvbnFRBKPfo+C6ZGsP5h93baXqrNUDkZDoe3IDpaL1NQgwbr31/Ud/DU0gD8KwojnLURPfVNMEOyVEobSOrUcC+BEJX+QNdcyJZRK5DFebS5lesEYlBIhy4H0xFYNhjk4sg+NgqFOxF5Nze/WvTbJvYF+rGANzqbvFUUQ9EnswpoVIHnKBB6x93YMYqzyEKVAl1cUXz3O0xipfcHvI8pFwi2X5jZ0iG4gFTnQoju6XIEGzi53zdxOEPxp1fKVgio+wz5S0faFogd+Q42JVW8Paqb04cu/+/KDoAyGQr4ACs4QovSmL4m7+zKZ3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nmeqN4aj; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nmeqN4aj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X3ZQ35F1Cz2y1j
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Sep 2024 19:04:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726045462; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=cQjbKqN2Va0/LLOZRFXrPPQKrj6uag96SglvKYLhG3E=;
	b=nmeqN4ajoHTE1XD8h1f8qes89GzaoBih+skazYB58fENT5TqjdzEu/oklBXobWuyWGDqloObqvWOLqN4IFKB8qUtBTDFPLLsjjWELiOF9XEf5OK9blLUGnI36vnnm+v/TCJqelfnrgy++mRUJvVPqJDPEbYL4l2peqA4xzGjiwQ=
Received: from 30.221.130.129(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEnHe4p_1726045461)
          by smtp.aliyun-inc.com;
          Wed, 11 Sep 2024 17:04:21 +0800
Message-ID: <b5f151d1-d29a-44f2-8601-5943e717cd07@linux.alibaba.com>
Date: Wed, 11 Sep 2024 17:04:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs-utils: lib: fix incorrect nblocks in block list
 for chunked inodes
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240911085531.2133723-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240911085531.2133723-1-hongzhen@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/9/11 16:55, Hongzhen Luo wrote:
> Currently, the number of physical blocks (nblocks) for the last chunk
> written to the block list file is incorrectly recorded as the inode
> chunksize.
> 
> This patch writes the actual number of physical blocks for the inode in
> the last chunk to the block list file.

You should attach "Fixes:" tags here as I previously suggested.
I will manually add for this time.

> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>

Otherwise it looks good to me.

Thanks,
Gao Xiang
