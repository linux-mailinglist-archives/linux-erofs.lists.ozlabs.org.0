Return-Path: <linux-erofs+bounces-1821-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD5ED11711
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Jan 2026 10:16:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dqRb81L8hz302b;
	Mon, 12 Jan 2026 20:16:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768209412;
	cv=none; b=e5ikIZ9MSEHh8+PbHr7TDtlWxi8BRq4h5ncz10Rly2EpWbFdpdhiYhTPSHjuD61/+j7BT4qI5EcEWs6ZDjLhqQ3rmu00XW2c9C6ngKn3CFN8Iu8paYbRzVof5mlY6mYpVBy+DQ5wHx3HnlCVJnr+f1h0HA/cT/OjjwM8m9h+m+2pWABYBgX4zbiPDwhZMTqUGRVqsoNZkz/3kbd+gPB3xWmocUeO/b7S82zXE+P2spHhCgAVXwDsckWUAwwSf6TJ3LI3MTZQbfhYircvdO0+xx1ELXHxpglGKDCmDio1GoFia8Any6aEd6QACPGHB89OYkbs01mbnhHHxqGptCELbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768209412; c=relaxed/relaxed;
	bh=ZDH9nqezE3EoFlMI3Tuxwce7Grm0B55r4St4aPa9ueI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PiBgF8ZD3bb5ac2FRB8LrNdDj4+tlPx6F4ZqIyRB/2iQTfXXLX4j+d3XoEMt476VJT/5DE/tKjDmMy3Pd5Nz1EwPjOxA5n2UJ+7+oRS24VaETs9Zhx5pRSUZ9ny5NC/1tgcxwNiWZ1umZyCTCttqQll2JmA6rdTGPheBp52NyUnE5rzz8nVPptubehq1UtwhhZEM7paVh/8D37iltSDxffYMyJg9fe9Ghb/Wa7upPPx7lcj17gkbIuCu7kxG2DOLxAZttPlFhCPkMv1Lmjj4kGTKvkiP5Jb5q5kHTH7oTb/MinOvjHaoPpv0PkLGQDo/QRRmVYxLltn1hdZscRVV7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TrbSKWxd; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TrbSKWxd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dqRb74VmVz302K
	for <linux-erofs@lists.ozlabs.org>; Mon, 12 Jan 2026 20:16:51 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CB62540E1C;
	Mon, 12 Jan 2026 09:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F3DC2BC86;
	Mon, 12 Jan 2026 09:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768209409;
	bh=ZlqPbIElFmOcYiMGbdmYihMMP6qIVvT2xhrPFLEJfuI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=TrbSKWxdiGMB5/qN4+MJumtDjOviTe4wYrtcZjmDclI3ikUulPM0NNf9921FeJsKT
	 cZT+1NcxEfXlRVrzjsaMjmtZOie69g2lzBmX0nfcEMNnp2Cla5CwNy7oL0koO98bye
	 H3U4WyPL0JpNI37RmqaNd2/rIUMhbMEgmaANdoZXCF1L63c+mCIgdtX/qUYd7BMCcr
	 Loj0PfJnaClY1GaRxwh6cvJWz/W8zsgAzIPzDOl39Jn73g1OKoI/07epv37yI2KV+2
	 MD3mxJFDwR8vWLjjwPR+/stKK0ylnzkTSsyuwB49pqktG1Xk/niXVJKCaEvQLOlmji
	 xvaW5PIWiuxbg==
Message-ID: <ba295eb7-000d-4af7-bb8c-1db5aea30460@kernel.org>
Date: Mon, 12 Jan 2026 17:16:49 +0800
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
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] erofs: tidy up synchronous decompression
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20260112034330.2263034-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260112034330.2263034-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 1/12/2026 11:43 AM, Gao Xiang wrote:
>   - Get rid of `sbi->opt.max_sync_decompress_pages` since it's fixed as
>     3 all the time;
> 
>   - Add Z_EROFS_MAX_SYNC_DECOMPRESS_BYTES in bytes instead of in pages,
>     since for non-4K pages, 3-page limitation makes no sense;
> 
>   - Move `sync_decompress` to sbi to avoid unexpected remount impact;
> 
>   - Fold z_erofs_is_sync_decompress() into its caller;
> 
>   - Better description of sysfs entry `sync_decompress`.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

