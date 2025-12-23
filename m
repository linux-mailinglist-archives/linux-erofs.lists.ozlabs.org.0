Return-Path: <linux-erofs+bounces-1557-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 090C4CD873B
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Dec 2025 09:31:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4db7XR5b4tz2xlP;
	Tue, 23 Dec 2025 19:31:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766478711;
	cv=none; b=Fmx1G3BFNBDDax536INzlS4CIHIc8vzqFa9X/bHjrjBHi7IBBrTkLdOSmDZFUzMB57gBe33DYbk/5D+TJ6O29RuASjE18vhnDo0YjyDPLJgbDUmbugMEHeiaHW0P7j1Lj2oiVmFgON4IKNB82XSRR5sQim1faOFyIW2MVQ435hBk2zvihnm1D0PC/VDNY96ZlAZgmp3holg/G4y/iutv+prlfTvHR9+qxdbkx5nzqq1SGceHu0qhH6z8P1aggAznkFtIXAsnEge4202gX8hNAno/ZvNqiWGOQ5fwLRno9SJ3xop3+DXTDBKHIhM1bdSG57ExwkBNB9+ML8pWnmznfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766478711; c=relaxed/relaxed;
	bh=QDHZ4gEUp+iF2Zx/V1T92i7/2FBuX9i2CFTDzZA/ECA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JUw5pAQMZ4b61p7kRGba1ZpxmTepseDhYndrWFxp+WmJ/YW4ODpxhgNwx8oWQxqVY5S+n0srvt3w2RWAzjjDBOjn7M2GEQEENcEOzYavuAF7D1rtxBuda5vjzPrRt80ArWG6GGRTtlXeTadtni6/CIXSffE6Ia5Am95DCvqt7eIqu43L0zMy7cyMzFFsZ13hppkJIKCj8PnDryVRKRyKPSi2dSedohpzK4rG46SWf7PFmeOmJiBETQhAiEAdZcvTxZb5dsQSCGFokpaj/tJB7R2WKDa3D4lxklClDjhEmVZXDOV1nr2kGjfphOJGqWhXimYcNgI2tu60sqisNXXRoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PBeDzRFC; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PBeDzRFC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4db7XQ61R8z2xQK
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 19:31:50 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766478705; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=QDHZ4gEUp+iF2Zx/V1T92i7/2FBuX9i2CFTDzZA/ECA=;
	b=PBeDzRFCDBWcuOTsH03cJriRE/Aibo9KXRAkAIbA91sQOQliXLkqNELzXV/g7Nedn4n/X+1YGhZ734xCzk+4eRXgtaz6QpCvsl27Rx75udXXI7Dod4BwcdKgKeSZrFg2ebEoLKfGsMmfOAL6mJzYgDJqjQ9SJVdMpQC8c8ldHCA=
Received: from 30.221.131.244(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvX.job_1766478702 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 16:31:43 +0800
Message-ID: <e143fe52-d704-46d3-9389-21645bb19059@linux.alibaba.com>
Date: Tue, 23 Dec 2025 16:31:42 +0800
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
Subject: Re: [PATCH v10 03/10] fs: Export alloc_empty_backing_file
To: Hongbo Li <lihongbo22@huawei.com>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20251223015618.485626-1-lihongbo22@huawei.com>
 <20251223015618.485626-4-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251223015618.485626-4-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/23 09:56, Hongbo Li wrote:
> There is no need to open nonexistent real files if backing files
> couldn't be backed by real files (e.g., EROFS page cache sharing
> doesn't need typical real files to open again).
> 
> Therefore, we export the alloc_empty_backing_file() helper, allowing
> filesystems to dynamically set the backing file without real file
> open. This is particularly useful for obtaining the correct @path
> and @inode when calling file_user_path() and file_user_inode().
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

(I hope Amir could ack this particular patch too..)

Thanks,
Gao Xiang

