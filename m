Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 609844841C9
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Jan 2022 13:44:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JSskk0Hh4z2ynk
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Jan 2022 23:44:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=l0yP4JUI;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=l0yP4JUI; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JSskZ58Bvz2xBl
 for <linux-erofs@lists.ozlabs.org>; Tue,  4 Jan 2022 23:44:22 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 52C1661365;
 Tue,  4 Jan 2022 12:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DCBC36AE7;
 Tue,  4 Jan 2022 12:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641300256;
 bh=2a7QZW9xS69GfqXcY08GEr4GrelI5J/qIXoo9JFkako=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=l0yP4JUI/V+aeqv1R3FEE5iZP6Co9PKXAuimnD0yIwK9MOvcBniiovvKdBCNoz6KZ
 4D57MPGgKr0/gf2WrI36N+hvz9ROu4RsnKfOuXgsuaIaHceLxuNZ67c+M+ni3oMBjq
 SOF2WOguhxG6pN8i3Y0NEXZ7gJPX0SE0Vnh+ZwANbeskXVxqYokOlgxFI6dzC5JpJ8
 YLbLHM7N6N5u2xY/NE5KYXBHo+L25Ioj5CQUxXqaUhsyzYE88fYVHthyS7mqSeB5p0
 kkq3Q+crMWYnw1ASRkWxxcs35HvvAiLzfr8Om/UaoqnaEY6WD7z++16T2Yn8A+QB+S
 eWWEayQZrN0Nw==
Message-ID: <22e4925b-5e85-141a-1e59-c140d35af0be@kernel.org>
Date: Tue, 4 Jan 2022 20:44:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 5/5] erofs: use meta buffers for zmap operations
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20220102040017.51352-1-hsiangkao@linux.alibaba.com>
 <20220102040017.51352-6-hsiangkao@linux.alibaba.com>
 <5ed798da-4f01-17d4-cba2-dda50728bd25@kernel.org>
 <YdQNCJzQULVxC2QC@B-P7TQMD6M-0146.local>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <YdQNCJzQULVxC2QC@B-P7TQMD6M-0146.local>
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
Cc: Liu Bo <bo.liu@linux.alibaba.com>, Yue Hu <huyue2@yulong.com>,
 linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/1/4 17:02, Gao Xiang wrote:
> Thanks for the question. Previously, erofs_get_meta_page was called
> independently without reusing zmap mpage, so the page refcount had no
> relationship with zmap mpage.
> 
> However, now we reuse zmap metabuf instead(fe->map.buf), so an extra
> page refcount is needed since zmap metabuf will be released at the end
> of readpage or readahead...

Thanks for the explanation.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
