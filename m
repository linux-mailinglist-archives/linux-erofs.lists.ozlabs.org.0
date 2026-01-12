Return-Path: <linux-erofs+bounces-1827-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC6CD1338C
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Jan 2026 15:40:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dqZmv0ryrz2xP8;
	Tue, 13 Jan 2026 01:40:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768228847;
	cv=none; b=FdjN5dnoxk6q8+0fL+jhuFzcFT9/pcnv5zI76bKajDA7idMbUV4nmvugPsu/OwDZTtSET5U4SsgZCrY3Ak7QZuiNmltlge5tFrjpRZQhTORrJpfk61fYp+FMFl3Weaa6/29ub3eHkMTTF+dV++dOt3jaACzkVEaxiAnDxKhHZzuCVXeSRdbqHmQPOkyoS373ViJ1nWnigVDvJ6pUUSQA/v9QQJpPWKBOdkIr+m3Pdg8D+RIkHb8B6QgHiC4apKUPlStHF8OM8w+Gdau1tI9505dLfe5MDUiB8tym9OkhPQIRZcTZuOpMwK9LFzxRVW3GGjSnpHOrMZr9yttfgmi7tg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768228847; c=relaxed/relaxed;
	bh=bWzdgp2CS2X31/zzChh3XFiUbP6b5dWYiArq4z741J4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c9+OiGvWVftY/JoGd4HIATMqy/EX4nbIbvhHFKVxeBLN7XmuJoAjTEuqv87QdccPVS+rCPWxBwgVAc0IGjWNqlHEfafubAoYWDgrCZNPM4P8nkLwMRk1FCWQmHE2ydtGAMKA/BOJPUGQb7QuG9w9o9x80sWUMqujkR3LFUF2bH8rMzOLKCkQfW1K+VHH4XsY9cTJ4bcObxRVCAHCSX7Cn+49i5XU3F+UpkRw8tHJ5uoSlPK3zYhdUJx2WuaoCANna1+3KHLzz+c6y4RXuDEfgYlT9Rsn7fWtEc4ytPbIQ3PvfnewJV8hZZJwvXPnk28tQcMp1HEzkJh7u9QVDlv5BQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JXsPCCqR; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JXsPCCqR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dqZmq67LBz2xHW
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Jan 2026 01:40:41 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768228834; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bWzdgp2CS2X31/zzChh3XFiUbP6b5dWYiArq4z741J4=;
	b=JXsPCCqRwRF6og5LMv3M4W3gbhJ2XAg0oswdO28Ei7KJBFz37iDiDzfcqKhE/4p4bV50/5LHNKnLELvzJuzdVOEIKmaaKTZdZTaVi3L4ojI3SGIyYxIHSa7GZ+eK3fNgJeZk93HbglB7YZNwVdQBlKrRfnKrwm5N3JeFvakAyoA=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wwv.v-g_1768228832 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 12 Jan 2026 22:40:33 +0800
Message-ID: <d6ea54ae-39cf-4842-a808-4741d9c28ddd@linux.alibaba.com>
Date: Mon, 12 Jan 2026 22:40:32 +0800
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
Subject: Re: [PATCH v14 00/10] erofs: Introduce page cache sharing feature
To: Christian Brauner <brauner@kernel.org>
Cc: chao@kernel.org, djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Hongbo Li <lihongbo22@huawei.com>
References: <20260109102856.598531-1-lihongbo22@huawei.com>
 <20260112-begreifbar-hasten-da396ac2759b@brauner>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260112-begreifbar-hasten-da396ac2759b@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Christian,

On 2026/1/12 17:14, Christian Brauner wrote:
> On Fri, Jan 09, 2026 at 10:28:46AM +0000, Hongbo Li wrote:
>> Enabling page cahe sharing in container scenarios has become increasingly
>> crucial, as it can significantly reduce memory usage. In previous efforts,
>> Hongzhen has done substantial work to push this feature into the EROFS
>> mainline. Due to other commitments, he hasn't been able to continue his
>> work recently, and I'm very pleased to build upon his work and continue
>> to refine this implementation.
> 
> I can't vouch for implementation details but I like the idea so +1 from me.

Thanks, I think it should be fine.
Let me finalize the review this week.

Thanks,
Gao Xiang

