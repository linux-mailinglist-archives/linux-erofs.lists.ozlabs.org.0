Return-Path: <linux-erofs+bounces-1448-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C84FC91D3D
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Nov 2025 12:44:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dHs053k7tz2yFy;
	Fri, 28 Nov 2025 22:44:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764330261;
	cv=none; b=mux6Rq5+TWjo7wXKQsa671obtFw5XG+6xxRzjKI8eMdZzEo6QF0OjirZZU8U2FcRjAksI9EBrnb0YMhuFPaye+9W+aT+poRn5dB2HBmK5AHW/YlzMvChwpdmAgTxUuTqr4LfO7RiPiGfKNEF75IlAPN1RxS7HI/BFRc7x4qLLajb6TWLjX5QiOeBYtj80pe5E3tl26CVDuVWPRCVm2S56VxQea1DO9T9YtTpKWaV7G0h17sXfK8rDjMVBkiACxtF+1E5WbWFqTFQ9RMOQJfxQJrrgzsKVVUovcIqYIX2hBvFL5804ToE+GY3A5KWAWZOulMzlSeROTW8wHmhRBol1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764330261; c=relaxed/relaxed;
	bh=U9eNJRkR27EZiyziJKtDYH9IuqQTokX9O4KYiHcdMUY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FjgH7r+wML1BlAXWuk/fV+embMqhAgxEByO8WLDGyBrMKLzm5dWIMrl6Y2rIR3+mVzKIxZgE6koX/pFedkjw1oqnLMjARk7kWjDhWf/xqDkTnYTEFfFJGd8Opu+cWVSu8IaV/BwEfDMlfPFUk9aAweijZwJdEEm478sOb30KQSjTh1YG7vSY1oXsaocXS7xRgWSEDvOSvJQ3gA3pFhxTBGzmUvuIgXvMlB9vAb0wuW0YLuIQUvxvyna9tPSD6D/DDIZLEqRDWsIphnsZQ2EFnJm9V1QhDNoPbaFsn7FIKlbfHQuJnlIKUmrxV6yfye3JWBI0xIILoJFDgxyx/C8tUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TJQl6XpZ; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TJQl6XpZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dHs05080jz2xP9
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Nov 2025 22:44:21 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DD03C43C51;
	Fri, 28 Nov 2025 11:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1560C19423;
	Fri, 28 Nov 2025 11:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764330258;
	bh=jPY5935p5z6iiUVLJ7/7Ch2onSJfyPw6Qo3ZxGW1DUk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=TJQl6XpZXXSMqB0GCX7UpX2ynTd5yxMZu8cN/tt/mu8XYiEj9GAXzWsAxIo/BvzCM
	 6BpaARCjb472ejKR1IOKp0TxtwUZkd0YKDBgEkp9OGCKJeFohyhR6RO0bZZlzLPcHL
	 wUNMCkzPaUjQ3p1mAMkx6KQRGm3nius6i5Q5Xgnb+18JYqgut2EhgyJ7rKL7/sgA7M
	 PwepMzGEw0KhRcDS7cS6XMnQzBX0+AEcEapxT24rNPbD7Up+YP3fDVLvzST07p98lC
	 aFtqd12KApSgcxnjFTIoym4FX3Vky9FTkDA1uujyA2YdZhLh6FTDE2gjGZzWRkALvh
	 FISPthKDj8eQQ==
Message-ID: <bcc1da70-d122-4b9a-8b3c-bc274b7ff6c5@kernel.org>
Date: Fri, 28 Nov 2025 19:44:14 +0800
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
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Ming Lei <ming.lei@redhat.com>,
 Stephen Zhang <starzhangzsd@gmail.com>
Subject: Re: [PATCH v2] erofs: get rid of raw bi_end_io() usage
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20251127080237.2589998-1-hsiangkao@linux.alibaba.com>
 <20251127080756.2602939-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251127080756.2602939-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 11/27/25 16:07, Gao Xiang wrote:
> These BIOs are actually harmless in practice, as they are all pseudo
> BIOs and do not use advanced features like chaining.  Using the BIO
> interface is a more friendly and unified approach for both bdev and
> and file-backed I/Os.
> 
> Let's use bio_endio() instead.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

