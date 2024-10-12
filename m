Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7F499AFFF
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Oct 2024 04:06:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XQRfx1NrDz3c47
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Oct 2024 13:06:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728698760;
	cv=none; b=PDJIgYNdP/867zseGSEcB9bZl1j2J73jiX+XSrOIEap5wlGQtPZFhrrvE8pWAQLHMQQSSGKbULRQzhY+UWKbbFrewsO+ZQ3XCMM/V9p1kwVystvZrM6M9Tt8G9Io6u5TIi7jSvnrVpIp/cZBak5oOOT/p7QgGBxPhMtY5HlvRHdcqWk7N2FAGdq3yjibHkzZ5mdfpg49tvMCnvQRIRvvWmlDkZ5KL41DWEKJgDysCBJV1x4zyVk8Il7pWOr1bvl84UxBuf3OejSvAeb2S8EcLNxKhQqxPlNx9AxK6q3DXnuJGp/KmQUk4xAsQVi/l147CJDNkFYI8XqpzMaqrTUadw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728698760; c=relaxed/relaxed;
	bh=E9ZCS1BAgqiWlxO7imDG8HI3u8IJNNhNbLV/ufS3VBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iLE8hwz15FraY1aPEdBQnZRINoNClIXnWyS4libA9jNvChddL6jpby1avc5KJ5qXB10+IoYklET191inZLmcA4/18bgwy/Zhca+l6Ek15cP1N4ZjvHQk0x07ezIp+oSSul9InRqVV6P/fVEbcmGxkcNQPTFfEUozeF5Di+yM5/jSpijH4MjMNFDLcy1YBK639anct2oB0435mgAxsbf8U+qHkCiWJRe+kiVL9vKWG5LSdC+q5gGiu/rSKZFv7aCHPEIPLqadMFu7fcCqvJjS5WT7hnOnCnC8WE6GCPe3fwt427Prq4m/J4y1t1eUYuehrWKxXlz5VGpesQd8UUSgIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yiIMt1ZN; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yiIMt1ZN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XQRfq0Nnxz2yZZ
	for <linux-erofs@lists.ozlabs.org>; Sat, 12 Oct 2024 13:05:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728698746; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=E9ZCS1BAgqiWlxO7imDG8HI3u8IJNNhNbLV/ufS3VBQ=;
	b=yiIMt1ZNZgeGfYyyTp7fqe51FdxluimLHVK0z3Tth4YL/RSSxHmJIrXKbCXKmhWwNS+UZzb8PT61NbkS8hcOpe2lIwqlh+avfhtNhw8kfR3qcVfcYo9qrh+LU21Oiz9C3yIKEydya19QKMqv0fyts38ntm9r5D3r2t9l7JtOROc=
Received: from 192.168.2.29(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGtMPio_1728698744 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 12 Oct 2024 10:05:45 +0800
Message-ID: <df3200b8-4fc4-4db3-a112-2f963a263b36@linux.alibaba.com>
Date: Sat, 12 Oct 2024 10:05:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] erofs-utils: Compression with -Eall-fragments
 segfaults on 1.8.2
To: David Michael <fedora.dm0@gmail.com>, linux-erofs@lists.ozlabs.org
References: <CAEvUa7njGB_7Xs4A+DhGBR0LZL--tAZNmU=3bFS+uVm0G8uULg@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAEvUa7njGB_7Xs4A+DhGBR0LZL--tAZNmU=3bFS+uVm0G8uULg@mail.gmail.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi David,

On 2024/10/12 04:22, David Michael wrote:
> Hi,
> 
> Version 1.8.2 has a reproducible segfault with "-E all-fragments"
> (testing on Fedora 40).  When compressing the install image, it
> consistently hangs on a firmware file:
> 
>> sudo dnf -y install erofs-utils
>> wget https://dl.fedoraproject.org/pub/fedora/linux/releases/40/Everything/x86_64/os/images/install.img
>> sudo mount install.img /mnt
>> sudo mkfs.erofs -z zstd -E all-fragments erofs.img /mnt
> 
> If you isolate just that firmware directory instead of the whole
> image, it will segfault:
> 
>> mkfs.erofs -z zstd -E all-fragments erofs.img /mnt/usr/lib/firmware/nvidia/ga102/gsp
> 
> It happens with all compressors I've tried, but adding "dedupe" works
> around it.  Is there any change I should test?  Let me know if you
> need additional information.

Thanks for the report, I will look into that.

Thanks,
Gao Xiang

> 
> Thanks.
> 
> David
> 
> Originally reported in: https://bugzilla.redhat.com/2318138

