Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F88F97E5A1
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 07:32:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XBs7y4d4Hz2yVd
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 15:32:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727069547;
	cv=none; b=SKPQNuyNB+fUNr6k6kpQmaendBk2XuYiT0iXsk7e1ONhUGV3TMc2vDhK2XA42XRx5WksJREjXXldudmHbQ6wuEW7uIJk4DNpCNTFnuB7KZwU9DE4ws4NmJaCFF/Pjx/q+vY4kDr24ybWXvhlZjhmZzg6SNr0a8zWqEk+dgYWjSk1HmNk+Y9wf7XPIMdn1swJqXZaee/kuhQPlUqPuSFE8uiL3eqc9F13pz/OtMyUpzLuJthEn/9cK9DqwlxAgq3oPeOZzLw26sReh2fN2EX+aczOKMPCTMg0ew7Q17fKwkcVsMvKKMDyl8hjzzYJgZpRvehTmSqHyhCIB+lg6F7qWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727069547; c=relaxed/relaxed;
	bh=YkzYuJE6Tur/gVhd9xp+2TsZxHQ1T2AosbdkMspRTYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V6+5sJPUGlBL84vUS1VE/0EQXuejStpLGFGlmIsgbN2xx6yd2umg47cCG/LkD82r8v/1mGwFX7N9DQm7vF3zQUrYEASafom9yL4kDNIn0g3JI7XwZyYCGvWTwNyYZk3cU1YEBwYBJlM/5MWud9cO7CPymMTCTTthWsCzv3wkMaMWp5nAN5lVVwf7S7sNPBctffZRaSl50fLaQlAn42FoO20IcK0atDSxq7WjCQpyZSn9eRpbOks0XCbWn+UaqOx6XYKHmfsRmrgX8vvIhPVqhMIY6WZLoPwh/QD9o+yVeayn2cqlO0eSQqVYSxnNtOWAq9ZRT+l8z+2RCHR/0wocnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AqdWuiCo; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AqdWuiCo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XBs7s6fQbz2xb3
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Sep 2024 15:32:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727069538; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YkzYuJE6Tur/gVhd9xp+2TsZxHQ1T2AosbdkMspRTYg=;
	b=AqdWuiCoGyhz8IVPbpN4MMd9mFK/1BX3dRRpHacAlgwGAh55U8du5g6U2sVuGAPmaDguuSIBzse06R1aM064LtvIzu2BjsE+DojevdTuX67pJ/HwiAQ7h/+EoLdXpKsXYgqhmG7ErP/qO6kM4SAtKX/aNLSHSlYyshOpwbDZZm0=
Received: from 30.27.108.50(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFSsur3_1727069537)
          by smtp.aliyun-inc.com;
          Mon, 23 Sep 2024 13:32:18 +0800
Message-ID: <07059dbf-9572-408b-a7b2-1ae259e4f31f@linux.alibaba.com>
Date: Mon, 23 Sep 2024 13:32:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs-utils: lib: fix compressed packed inodes
To: danny@orbstack.dev, linux-erofs@lists.ozlabs.org
References: <CAEFvpLeBDf_BjwJJRc3Ecn7DMZNkFYsAri6=dy7ERQ2SFLmhFA@mail.gmail.com>
 <20240923051759.7563-2-danny@orbstack.dev>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240923051759.7563-2-danny@orbstack.dev>
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



On 2024/9/23 13:17, danny@orbstack.dev wrote:
> From: Danny Lin <danny@orbstack.dev>
> 
> Commit 2fdbd28 fixed uncompressed packed inodes by not always writing
> compressed data, but it broke compressed packed inodes because now
> uncompressed file data is always written after the compressed data.
> 
> The new error handling always rewinds with lseek and falls through to
> write_uncompressed_file_from_fd, regardless of whether the compressed
> data was written successfully (ret = 0) or not (ret = -ENOSPC). This
> can result in corrupted files.
> 
> Fix it by simplifying the error handling to better match the old code.
> 
> Fixes: 2fdbd28 ("erofs-utils: lib: fix uncompressed packed inode")
> Co-authored-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Danny Lin <danny@orbstack.dev>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
