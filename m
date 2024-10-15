Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86C399DD2F
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 06:31:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XSLl24pznz3cH2
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 15:31:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728966668;
	cv=none; b=IiFZtMud23/Gwih15ZaUUYiw3Jbtj7S4lzopZzBr2CB2F3zlTNOvgBtPtbbP4SO15cG1TbVtx4vpnB+9QJTtGN+kxx1XKEomEdxpf3B4B5aGhK5MgdcMduO4Yzye0AxsuJFrwA8UZPySrUfOKZw7UHZ/vjYuyQSNT0SuY33LutxRJwM/B+h4V8xDkgxydZJ1+xOUgmGO6McdUUOpa+8RiOuVGzcuOi3pli/719ZFtwXkBtewtRnye3vh9b6DEE0XCCIZBmpiAHvbO0hxsPoSiI8r+NwglMN1jvhiu7ReCkW3Bmrh/28FNZvB4RVq796+LYsECjRFeETYpEXvhilWeA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728966668; c=relaxed/relaxed;
	bh=6YQRKe9Sij8fqzL3W2juIFPDKDXqzR4cJmD647qt1Es=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VkU2fU0XD433CRB5KKmS0iJBWk6QZIDEXI/4F4gwsNBoM1MNlwBSpFAMaWwnslauUaApOBJc7ZYlrqF4DydRyGCCD+1fByTxxCK9NGzJIaRFoCTUSGHKqP/e+8LQh/IoqL1YFNHYswZqqmaSjrKdOdqAUszYSXMjhyvdtsluFLf0GQsWJoM7vLYgVVx4+kQRA7GorNJ1Q2tNDnaGiHmd+tZXKOsvulD8uEkVJ6YpCXw4SqnRjzLTzJDjG17+IC6C0iGrKrcJoI2pVTLjwvnVZZwWOyk35rgS+FZWvRCp0xaSf5HVYePGD8X7Vi+CDRsUi59lWG0hq1qW9NwC7DjibQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wErw9Hav; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wErw9Hav;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XSLkr44Qjz3cF4
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Oct 2024 15:30:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728966653; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6YQRKe9Sij8fqzL3W2juIFPDKDXqzR4cJmD647qt1Es=;
	b=wErw9HavjgqZUxJGYm2ZvwlN9hwlnAQ3wAcOOm9E2TFmZEJHNHIPQU6tN+LU0Sts8IV9Naa9J2ViaggwK068ifyKVcTUxqdrqsuYjVOXIy5JiRuwlWUmBRELonicaj3M6TZL6TlZuOaBxz5Y6dx8B0C6WK+WZ2L1WrDf7pxztYE=
Received: from 30.221.131.163(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WHC21-1_1728966652 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 12:30:52 +0800
Message-ID: <a850712b-12b4-43a6-98e1-4f4c2bb779ff@linux.alibaba.com>
Date: Tue, 15 Oct 2024 12:30:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: tests: add test for file-backed mount
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20241014150359.2185347-1-hongzhen@linux.alibaba.com>
 <ca1304e4-10ae-4721-9e61-5e8274743234@linux.alibaba.com>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <ca1304e4-10ae-4721-9e61-5e8274743234@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


On 2024/10/15 11:48, Gao Xiang wrote:
>
>
> On 2024/10/14 23:03, Hongzhen Luo wrote:
>> Test for the file-backed mount feature.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>
> I think we need to run all previous tests for file-backed mounts,
> and it's my previous mount helper for testing.
>
> #include <sys/mount.h>
>
> int main(int argc, char *argv[])
> {
>         return mount(argv[1], argv[2], "erofs", MS_RDONLY, argc >= 3 ? 
> argv[3] : NULL);
>
> }
>
> Thanks,
> Gao Xiang

Sure.

---

Thanks,

Hongzhen

