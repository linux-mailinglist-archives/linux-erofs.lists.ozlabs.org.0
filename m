Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F4B9E1564
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 09:15:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y2YP81290z304Z
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 19:15:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733213722;
	cv=none; b=Nflf5eOe06kkCg6LxoJ3vIn9QWbEP+qBkptGRE4xoRsJYxV1U1MVjgW5qi1/36hGdeCa8yN1Y9xOu1Xd2ofIvS+OyuLFPMfZQueKINl4dOpiUDK2/AvG7RIWddKUvLwOQ541NUcCouxPpjojUKuRkzeX9OtnCKBpozhNxyTZShCcTdN+z0URYZ001wO+XNsq6JB0bSZNR3SpUHI+AgL1kWR77mJjMelVz1rqhwr8j/Ac5LkApO1493wXx8gYOytsfyRzXXXF5QCs8HUErBtLAeAbZfNdta41tc8/dZeDcrYPb+QdKQELAvm0lbom3pZ6XhMdn9qjvppKmibKCMevrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733213722; c=relaxed/relaxed;
	bh=P9bXSc8Mw7fyXPHQ8KEsd7SMB95kevoVh98GxRCDL0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M6n+KzcT35AjMiKO8fHr7m24IfyyzsGgb+RBKBqObmWDBPoABGzVw3Qn3l+enntZN6y7McoAxIKOUt8S5PHgWhUFyG5Wyujr+AlIjZK3LOtIoP1sZQwQd5W6x3ozHOgEtIkKh/uouslYFjBLeeNoSWjNlnqa0jQXqdnCFjvcVSjeq9SVWF8Ey65CTwvY6RFOGcNAW65U4xc8ZFhE1mQCrygusr12s8ZBBWC7CmQAPfEg5ybYcAbiV2X6h1apSGTntZ74JqnSRLT2u0U8jV0xjWddw1bfqsiwdHKfgoFnu0VPf6s5OdUBPQ1J1AJOHJa63yP6VsmrN5Bx9G3ZATZSYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aHtMFiHE; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aHtMFiHE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y2YNy5VJHz2xgQ
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Dec 2024 19:15:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733213706; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=P9bXSc8Mw7fyXPHQ8KEsd7SMB95kevoVh98GxRCDL0w=;
	b=aHtMFiHEbFDhGu1ihTWcEnnXR3Z2oQIYqsF7Z9J0LXbc8ln0+qlXss/Zb5snHJR3aCtijv/+mruE11RtNfSyIimXQacaLo+pURKz0m/pxy1gNL5Zex5tsbz82iqh9fAsn7PPxPJSfEVysLR8oyTZThYo3fSn8C05mfUXkQin398=
Received: from 30.221.129.129(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WKm.qCN_1733213705 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Dec 2024 16:15:05 +0800
Message-ID: <0584d334-4e75-4d35-be33-03d6ff7a0aba@linux.alibaba.com>
Date: Tue, 3 Dec 2024 16:15:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix PSI memstall accounting
To: Max Kellermann <max.kellermann@ionos.com>
References: <20241127085236.3538334-1-hsiangkao@linux.alibaba.com>
 <CAB=BE-RVudjkHsuff5Tmg2sumjDkPKpQ9Y0XN2gZzPFxUGa+hg@mail.gmail.com>
 <b68945e3-3498-4068-b119-93f9e5aaf3ad@linux.alibaba.com>
 <CAKPOu+9iDdP9zVnu10dy3mR48Z1D0U1xyCuZa3A6cYEFKD-rUw@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAKPOu+9iDdP9zVnu10dy3mR48Z1D0U1xyCuZa3A6cYEFKD-rUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/12/3 16:02, Max Kellermann via Linux-erofs wrote:
> On Tue, Dec 3, 2024 at 2:42 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>> I think at least this patch resolves a recent regression,
>> I guess we'd better to address it first.
> 
> Certainly your patch is an improvement, but maybe this just wasn't the
> bug I was experiencing.
> 
>> As for your reports, I think we might need more information
>> about this, since I don't find more clues from the EROFS
>> codebase itself.
> 
> What kind of information do you need? I posted some high-level
> information about my setup here:
> https://lore.kernel.org/lkml/CAKPOu+-_X9cc723v_f_BW4CwfHJe_mi=+cbUBP2tZO-kEcyoMA@mail.gmail.com/
> What else do you want to know?
> This triggers pretty often now - can we improve Suren's patch to
> record and dump more information when this happens?
> 
> Right now, we don't even know if this is an erofs problem (and if this
> ever was). It is just one of several candidates.

I have no idea since I'm not working on PSI stuffs.

But I guess you could record more frame addresses to get the caller
of readahead_expand()? e.g. __builtin_return_address(1)?

Also btw, is _RET_IP_ stable among all cases as readahead_expand()?

Thanks,
Gao Xiang

> 
> Max

