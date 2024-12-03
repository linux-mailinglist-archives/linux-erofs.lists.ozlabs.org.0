Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8639E1163
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 03:36:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y2PtC1NTyz301f
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 13:36:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733193393;
	cv=none; b=ZqX9yF2H9NVF3ec9LhxgpQnjapwxj+c/f2uaWFtB0U6m7quMYatVtzWl020Mxu74/E66T3H1ue8Wp61Nx95vbzZ2KQJxA3AhvE0BUWf1MxmqfGj5hCelZKgLSuYTiCuPB9E7kRt3SE/k608sYa3k4Fct6JWHpQTwR+ClnC3RDO8C6BEsiLdF2gh8qj4W6WbBVS/+HWWcHwYvJYU46WmZ8c5ZSkAp1pGsKrgolI9ZLVU+aNT9sFyWZXtmqkXKo7/R4tvehPrANPe/vnC1GLiAa7LKaayh5T6XlAN+GZhdgPhYEtO9XXVVmSQTROxYd0s0JPoxzjXYG3epVYKImqq+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733193393; c=relaxed/relaxed;
	bh=Sju/tH3q8xFRQRDsxvt2vnwsD3XkrAxFoLFmGr026FA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nlr0CKgs1vv+/KQSy7PnsqfgElFzU5ZkrRFxRSaSeskkhcyu2a4bneBwZzFYE1J+InSydllQGkUuLtnJh/gaBF7gPdYyZJmEmPzG3pTyZxLbWVmFTmw3fBPMkIfhsh461K4qB6K0LACXoh4LkB9K4dvK3tAWpEen4xs/k9aFSodNyIEjLvCzFx9rfplDt9+5E+LZ0YUgNd/DyH6wsoPdMWdPJLa8r5p1wdPH4w1HTXRx8G6QJ4kFX2CBSVqNwjXqKzAt/bLcOAKWXLcJDXVVzQ4wVHpBsNCgdHvIM3GerLn+HL4I1+eDBBu/YQQ8/FfEzYyj8PHH29J8cVQRGJu5zA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mX7WZpWH; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mX7WZpWH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y2Pt64SFLz2xpm
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Dec 2024 13:36:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733193380; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Sju/tH3q8xFRQRDsxvt2vnwsD3XkrAxFoLFmGr026FA=;
	b=mX7WZpWHaxmNinxYxG1nP1uJS9+P92AarjhvPHmQrkF6pxHYYktxLFfsjXUOJGbWff47Qw37mYopdxzI/XHH+rUReMB3bxNX3SKrqLjJfE65U+lgkf/FVhW2qg72l2/DSlBpLflzgB0Qqhseo17giZsANu65SK5NdSYMnDi/xkA=
Received: from 30.221.129.129(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WKl0vK8_1733193379 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Dec 2024 10:36:20 +0800
Message-ID: <b47f5ed4-dfe8-4ecd-b69e-4907f3a1e04d@linux.alibaba.com>
Date: Tue, 3 Dec 2024 10:36:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs-utils: mkfs: use scandir for stable output
To: Jooyung Han <jooyung@google.com>
References: <20241203002720.3634151-1-jooyung@google.com>
 <a5b7aaf8-4b94-44dd-9bff-8e12080a8063@linux.alibaba.com>
 <CAO-8PLbD1hbRW24Xu+kJ6Ak9JZ+508sYgMa1oDB1PQ77YUptXg@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAO-8PLbD1hbRW24Xu+kJ6Ak9JZ+508sYgMa1oDB1PQ77YUptXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/12/3 10:20, Jooyung Han wrote:
> Hi Gao,
> 
> I found that in the loop erofs_iget_from_srcpath() is called in
> different order due to readdir and erofs_iget_from_srcpath() calls
> erofs_new_inode() which fills i_ino[0] for newly created inode. I
> think this i_ino[0] having different values caused the difference in
> the output.

Oh, okay, that makes sense, I think we'd better move

inode->i_ino[0] = sbi->inos++;  /* inode serial number */

to erofs_mkfs_dump_tree()  (since we'd better to leave
i_ino[0] stable even without dumping from localdir later.)
and even clean up a bit.

If you don't have more time to clean up this, let's just
commit a patch to fix this directly.

Thanks,
Gao Xiang
