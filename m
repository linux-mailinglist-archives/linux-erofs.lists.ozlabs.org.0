Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A959999B5A2
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Oct 2024 16:42:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XQmS04RGSz3c2R
	for <lists+linux-erofs@lfdr.de>; Sun, 13 Oct 2024 01:42:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728744158;
	cv=none; b=gVLgvz23dz0syS8Kt6mkOnIcVBs2hZkdTevbjF8DBuEW5Nt+H8Nf2Xd8RB58FC5kyUDzOWHPCCqro+UoeNcJyapEnOQzniu8pzAnx7XF756JrB53jz7MgqY31r3wyG3IL4+KY/CRb02CiiWtdsYr2kvp8bzPrvhWWKlHnD2ADAB2guUJDSkkB1yvrH5J0tXnX/xA96jDz7/QuKsX4oCT8wRFuSWMd2PEaqhKihhKMbfRlKMm5byz4tJiZ2vV6k77X5kS0ndEtj+ZaGeE17G7fo6H5zzlzUwfL6z/H7o5bWWNaSw09SiBos9l/Kjaocr5sIwg39SdWPJdEXGfJxIaZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728744158; c=relaxed/relaxed;
	bh=3kyCi4kKDuPvuc+QMIxYtbn6ey74vHsk9lKfNywhSV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLRPN1tld/QFmKi/hyQ7GES++lAzjwE+gLaUtvU+FZvkT8F4aF1oUSMfYMvG83mZY1QXx81uinW85lH973TfLIs8r1LUfcF1lp8leE/OsbsVN3nL0wetVSwB/BpMLeJadLwwok2NAx8z2R+Avv2tuhB+j6KERpVMEKR/O2QURAuUDFzJ+Jo0JrwKRrgDfJciAe/3xVl+OPunHgn8xxQF70j5jEA5DnOA7s1GZgl1/5vIIRa3ia+jdl+ErXaTKVmJd9v1NRf7r6qC1CSl43dhdC+OUExhrlObvMosHFt5WA4ChuOOfBpMrmS8CMuacf4bmRmEsgQ0cGoLFFMzJ+OKUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PuMddY2o; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PuMddY2o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XQmRq4VsTz2ygG
	for <linux-erofs@lists.ozlabs.org>; Sun, 13 Oct 2024 01:42:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728744137; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3kyCi4kKDuPvuc+QMIxYtbn6ey74vHsk9lKfNywhSV8=;
	b=PuMddY2ofTl2LlUjA0F1SWSDRhauG/jUZSAMAIz/JPIc5GBWVIY9s0cjhpim5SlUkSVuwtwdgy1x7Le4v7aR4QlDjxIwT8cO2wnDSplbZ35dqCG1Zx5vQRIcm5Tuf12vuVnnhp41CxRhuy1WMzO7xi1UuU28lr2qjYPQHN18lbo=
Received: from 30.27.69.130(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGwdSKm_1728744135 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 12 Oct 2024 22:42:16 +0800
Message-ID: <6756c1ee-b9d9-47b0-8b78-930ba341dccf@linux.alibaba.com>
Date: Sat, 12 Oct 2024 22:42:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] erofs-utils: Compression with -Eall-fragments
 segfaults on 1.8.2
To: David Michael <fedora.dm0@gmail.com>
References: <CAEvUa7njGB_7Xs4A+DhGBR0LZL--tAZNmU=3bFS+uVm0G8uULg@mail.gmail.com>
 <df3200b8-4fc4-4db3-a112-2f963a263b36@linux.alibaba.com>
 <6076d690-9b69-4821-a0c8-4172a4f47c9b@linux.alibaba.com>
 <CAEvUa7=6PkPLhX+jq2SykD95j5XSHoPC=yu8Nkf3_kgOCjsCAA@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAEvUa7=6PkPLhX+jq2SykD95j5XSHoPC=yu8Nkf3_kgOCjsCAA@mail.gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/10/12 20:10, David Michael wrote:
> On Sat, Oct 12, 2024 at 12:35 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>> On 2024/10/12 10:05, Gao Xiang wrote:
>>> Hi David,
>>>
>>> On 2024/10/12 04:22, David Michael wrote:
>>>> Hi,
>>>>
>>>> Version 1.8.2 has a reproducible segfault with "-E all-fragments"
>>>> (testing on Fedora 40).  When compressing the install image, it
>>>> consistently hangs on a firmware file:
>>>>
>>>>> sudo dnf -y install erofs-utils
>>>>> wget https://dl.fedoraproject.org/pub/fedora/linux/releases/40/Everything/x86_64/os/images/install.img
>>>>> sudo mount install.img /mnt
>>>>> sudo mkfs.erofs -z zstd -E all-fragments erofs.img /mnt
>>>>
>>>> If you isolate just that firmware directory instead of the whole
>>>> image, it will segfault:
>>>>
>>>>> mkfs.erofs -z zstd -E all-fragments erofs.img /mnt/usr/lib/firmware/nvidia/ga102/gsp
>>>>
>>>> It happens with all compressors I've tried, but adding "dedupe" works
>>>> around it.  Is there any change I should test?  Let me know if you
>>>> need additional information.
>>>
>>> Thanks for the report, I will look into that.
>>
>> I've submited a fix for this,
>> https://lore.kernel.org/r/20241012035213.3729725-1-hsiangkao@linux.alibaba.com
> 
> Thanks, this does fix the issue for me.  I'll apply it to the Fedora
> package unless you want me to wait for another tag.

I guess I won't tag a new version for this (but I suspect it
will need another 1.8.3 in the future), so feel free to apply
directly :-)

Thanks,
Gao Xiang

> 
> David

