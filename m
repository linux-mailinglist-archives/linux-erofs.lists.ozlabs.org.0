Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 731B69A33EF
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Oct 2024 06:43:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XVBst5hkHz3bn9
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Oct 2024 15:43:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729226609;
	cv=none; b=lzUGTFD+A1e+200FD2enTwRZjiQM0s//EMk1ApWAOVd8Jz76EWWtmdfytgNkyhwW/90pkdYBLK3pIa7n22TZmDwEzhRj6DsOtqvgSVZmqlYKSnrhgZ6uCe5/9LEx3zof3/levGqlbCbx/j2LSLtyCDzZxOIckcyAYFj/P9zgF1VZburB0wyLB9BfMGq/vuDZNggvolCzCNvFq/uzkkHPa5sUlaZXLx/lLgdBmCHvA2zqRHdQJV+TkyCjK/8fb34gRYXsp2DmLSrso92BdjXQAX16NvNpGes/PAyyJcJRxds7vV2LfOI0ExZ1hId8qT1uezmPVZUxIPw5zjqvwo0AxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729226609; c=relaxed/relaxed;
	bh=137QX8EpXYzRoAm1DZC6PZJEvNQCF2WinR+2tr9erX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mrRCE/a7PPuM1RN8lEOQkHocAeGzmsLT/DtxKxV1vOoBnKe/dBrXj3qgLvHkPSxyMtXJY+NVvSmDIWqUEsVEqaZsuK3B36Vo/RAmkm9lTdFIL36f3yy6AUN3TuXh0BCGFLxwiuXcOrXukBPDOG/WKA9HtVpmFONyM6LlWQxdprGc4hvjgz2pl17xdD/U18MYtNEV2eqpcBdWPaYgA8Ea06oQL+l52mWjCFIxZtVQd5fzAOuyF4kn8pqThnilsIQU/N81tOlZnX/lsrfb01cyR5Ed8quCmMtsc8AERzH5R/5oarBl0UAIGcHbvfZAtwvlosmaGcaPA42cm+jyYRbeyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=x0IMCsKH; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=x0IMCsKH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XVBsq2T1Qz2yL0
	for <linux-erofs@lists.ozlabs.org>; Fri, 18 Oct 2024 15:43:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729226596; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=137QX8EpXYzRoAm1DZC6PZJEvNQCF2WinR+2tr9erX4=;
	b=x0IMCsKHiOkQPmeJafsqxi2J/23H+bD/4saKwrFDfGKQKvLbQY7rY9CCqcx9GCXMmrKr3/6cVHWYxW6blMdXobyZLSXHjyXIeTnq4yIsOQehvjPgCO7vXXfluE/S5Jae0eTXXPhTvNZDDjO0ejK1t4svDALljjtvT9yrlpKBCx8=
Received: from 30.27.73.141(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHMnL0F_1729226594 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Oct 2024 12:43:15 +0800
Message-ID: <0db205f7-85f7-41ec-93f7-2077ee3dfb9a@linux.alibaba.com>
Date: Fri, 18 Oct 2024 12:43:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] erofs: get rid of erofs_{find,insert}_workgroup
To: Chunhai Guo <guochunhai@vivo.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
References: <20241017115705.877515-1-hsiangkao@linux.alibaba.com>
 <cd756ca4-e83b-4b10-8792-fc0f1c1ae2fa@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <cd756ca4-e83b-4b10-8792-fc0f1c1ae2fa@vivo.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/10/18 12:30, Chunhai Guo wrote:
>> @@ -789,7 +798,16 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
>>    	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_NIL);
>>    
>>    	if (!(map->m_flags & EROFS_MAP_META)) {
>> -		grp = erofs_find_workgroup(sb, blknr);
>> +		while (1) {
>> +			rcu_read_lock();
>> +			grp = xa_load(&EROFS_SB(sb)->managed_pslots, blknr);
>> +			if (erofs_workgroup_get(grp)) {
> I guess here should be modified as below, please refer to
> erofs_find_workgroup().

Yeah, nice catch!  Will fix it in the next version.

Thanks,
Gao Xiang
