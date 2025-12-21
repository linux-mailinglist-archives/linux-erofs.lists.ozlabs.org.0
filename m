Return-Path: <linux-erofs+bounces-1524-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 711D1CD42A2
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Dec 2025 17:00:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dZ5Zy5vMDz2yFQ;
	Mon, 22 Dec 2025 03:00:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766332826;
	cv=none; b=ZJSBy1BpLVFmTXuIYf/eGOo4uDhBo+6m8Sp20LhCaj5/ZkuVXVt+zzGZ3kiMv2bL0js94w0BTqvHsicLhwHSuxu1qpbeFAgEMhDI+7t/+PwusdxRQgrdYK1Xsgui9Un7kyVCsFUDakgE1eGLr7LMe1fPIWQDWrFQVNPm/2cj++YogV60QZ03lo4ZXavPKYvGZLK22zCLTa3U/i+j5/xw+xwprngVBpjH25QjjFtarMexZlmnjg2Re4TdIHvxP93/4zW2GhaejF7/kP7mgF6OBrF11TxmDG7SZDU4QoprO09kM2ET5uNqiMBtBjzs+cRg96v9PdefWkTE3tVpvGjAyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766332826; c=relaxed/relaxed;
	bh=sK5t599nMi0FN+wbtrBnMxUfbuG0tOLHfE9SiH9PK3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfE6HcQzZ9wpgemLOHpHWARVwCjNnKpIiZOi0ci7XN6WVEVWMU8PQVRoZmeswSKzCLNDUUKOECJs93CrYdskPH619yqjBX/dLcdiDBbm8tqT/DmkyF0M9FHL6vG8VRLUsK6lcAKHnWz07x+ppeGq+fqbLu31JNuphlC7TmsNweuzmsfkqauMa8nO2Cia0Eq/qeFTay1APKr/mOdBIY5gZbDQ62caLTlrWfZ/3GkYnVAXLJkRR5jpVwsLP0+1HxcNmK7PWT+xrwMPMhOphR28TR7Kv9oADyG6esst/vAQfrZM8yj2O3K2ha6DXL/zMAyg27rNZczKHF3nWwfBtFmVjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MQ0YrHOh; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MQ0YrHOh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZ5Zw1pJQz2xQB
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Dec 2025 03:00:20 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766332812; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=sK5t599nMi0FN+wbtrBnMxUfbuG0tOLHfE9SiH9PK3I=;
	b=MQ0YrHOhLtzcoNbPOk9ic2++EC8yY3lqDbOARU5KWFKv34v6Dqq4YIH8Gz07YlT/s9dxgHmQFKSjzndWeL2FXFQm7HpFyDCENjPxccK8p8NVl3W8c9obRPqRtnABUTimJlFP9AvQXwePRps0gz6btdr8SG7q0TLFag/zutaPqtg=
Received: from 30.69.38.206(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvJ9WZt_1766332801 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Dec 2025 00:00:09 +0800
Message-ID: <b0a8a71e-f232-4555-9e5b-e62e21b93b5d@linux.alibaba.com>
Date: Mon, 22 Dec 2025 00:00:00 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: fix unexpected EIO under memory pressure
To: Junbeom Yeom <junbeom.yeom@samsung.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Jaewook Kim <jw5454.kim@samsung.com>,
 Sungjong Seo <sj1557.seo@samsung.com>
References: <CGME20251219124044epcas1p3df48558b10b0540c2ea1ec65779c261d@epcas1p3.samsung.com>
 <20251219124031.2731710-1-junbeom.yeom@samsung.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251219124031.2731710-1-junbeom.yeom@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/19 20:40, Junbeom Yeom wrote:
> erofs readahead could fail with ENOMEM under the memory pressure because
> it tries to alloc_page with GFP_NOWAIT | GFP_NORETRY, while GFP_KERNEL
> for a regular read. And if readahead fails (with non-uptodate folios),
> the original request will then fall back to synchronous read, and
> `.read_folio()` should return appropriate errnos.
> 
> However, in scenarios where readahead and read operations compete,
> read operation could return an unintended EIO because of an incorrect
> error propagation.
> 
> To resolve this, this patch modifies the behavior so that, when the
> PCL is for read(which means pcl.besteffort is true), it attempts actual
> decompression instead of propagating the privios error except initial EIO.
> 
> - Page size: 4K
> - The original size of FileA: 16K
> - Compress-ratio per PCL: 50% (Uncompressed 8K -> Compressed 4K)
> [page0, page1] [page2, page3]
> [PCL0]---------[PCL1]
> 
> - functions declaration:
>    . pread(fd, buf, count, offset)
>    . readahead(fd, offset, count)
> - Thread A tries to read the last 4K
> - Thread B tries to do readahead 8K from 4K
> - RA, besteffort == false
> - R, besteffort == true
> 
>          <process A>                   <process B>
> 
> pread(FileA, buf, 4K, 12K)
>    do readahead(page3) // failed with ENOMEM
>    wait_lock(page3)
>      if (!uptodate(page3))
>        goto do_read
>                                 readahead(FileA, 4K, 8K)
>                                 // Here create PCL-chain like below:
>                                 // [null, page1] [page2, null]
>                                 //   [PCL0:RA]-----[PCL1:RA]
> ...
>    do read(page3)        // found [PCL1:RA] and add page3 into it,
>                          // and then, change PCL1 from RA to R
> ...
>                                 // Now, PCL-chain is as below:
>                                 // [null, page1] [page2, page3]
>                                 //   [PCL0:RA]-----[PCL1:R]
> 
>                                   // try to decompress PCL-chain...
>                                   z_erofs_decompress_queue
>                                     err = 0;
> 
>                                     // failed with ENOMEM, so page 1
>                                     // only for RA will not be uptodated.
>                                     // it's okay.
>                                     err = decompress([PCL0:RA], err)
> 
>                                     // However, ENOMEM propagated to next
>                                     // PCL, even though PCL is not only
>                                     // for RA but also for R. As a result,
>                                     // it just failed with ENOMEM without
>                                     // trying any decompression, so page2
>                                     // and page3 will not be uptodated.
>                  ** BUG HERE ** --> err = decompress([PCL1:R], err)
> 
>                                     return err as ENOMEM
> ...
>      wait_lock(page3)
>        if (!uptodate(page3))
>          return EIO      <-- Return an unexpected EIO!
> ...
> 
> Fixes: 2349d2fa02db ("erofs: sunset unneeded NOFAILs")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jaewook Kim <jw5454.kim@samsung.com>
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Signed-off-by: Junbeom Yeom <junbeom.yeom@samsung.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

