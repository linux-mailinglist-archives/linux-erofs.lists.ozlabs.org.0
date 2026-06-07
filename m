Return-Path: <linux-erofs+bounces-3521-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MPESAjhWJWqlHAIAu9opvQ
	(envelope-from <linux-erofs+bounces-3521-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 07 Jun 2026 13:30:00 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77887650733
	for <lists+linux-erofs@lfdr.de>; Sun, 07 Jun 2026 13:29:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=opBpCm43;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3521-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3521-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYCdJ03gWz2ySD;
	Sun, 07 Jun 2026 21:29:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780831795;
	cv=none; b=e6luDIFrdj22Jbde2a1kYGlxmZzb8L0hK04X7Q0YAlIEKxCLiafpG7pkMF9sLmCTUWFqkzaAdPElsEr+dbRJMhVDmwNayzFsaMJF6M6B9TFYEVUO0QuJcD7Ak8M8XnHOKmjvpAPDvuXudYFrWhltbeQ7Wc3y919RN9CKnC/djgtpupUtsLKx/zVez5yEMgD0dN1jKK38uNyAUTatgaCtEH9JXiVn3Rkre2bno0gHa/Wu/0ysth0y3KkoHXYd0fzQeQjDotaSkOA+eL++Xzsis22vFf0K6Rn+4ZWTZJuNDlL7JXrSVU9ZO0YR6NXi7VAU3Rd0ILuH2QIOV5EIbc9/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780831795; c=relaxed/relaxed;
	bh=1hzsraQ4artZAo5uyrEsoD73UbwNnmz77UyuRLdwA18=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C8yIQCgJW3xll4p4OhgEExtUiPO0oBHymVYhkXndORdEwOnsknrVpxo/tN8S+3UJZnTYGOidWc7tVWLlP3YP0WXEIMMwPaN4LxyMy2I9FoKOgQRJdcAkkne5WeGAhLVOeCzPniks2hwYOkkVZggXCeyPYG60HgooCRGg2wR0FIY5Yq3qzOhIUBmgEx1I5OkXqm9Jca7/KLA5xu3KANo/FaxwRn2+Zh7qcs4f+jEZ/gGkEr1mtM+3afM9ubuNLgyiebhEXMT+He5qQwTyGQmXwljyaZ5dHBlH48SM+gHmuAtok7WP9RXtfeNPaabRs4fIoj3/6gmLN64Vm5EKa+E31A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=opBpCm43; dkim-atps=neutral; spf=pass (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYCdD1zX7z2xlV
	for <linux-erofs@lists.ozlabs.org>; Sun, 07 Jun 2026 21:29:48 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1hzsraQ4artZAo5uyrEsoD73UbwNnmz77UyuRLdwA18=;
	b=opBpCm43EZRyXFHPUfa5dL2A/l90l265yfJmd3CHHdHyq9Jdg+qkS+SdKmGvzrFxeVub8WUvt
	KRUaIRiPjbrGKaKRAsKdwbLRyZ8XolGcCmbfYimuL0PTO8nwMPpByIpj2tz1zBm0HIPkcHP7wT7
	N0+wmAxpi5xYPrp+EozZ7eY=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gYCRR5xHQz1T4G9
	for <linux-erofs@lists.ozlabs.org>; Sun,  7 Jun 2026 19:21:23 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id AE8A240571
	for <linux-erofs@lists.ozlabs.org>; Sun,  7 Jun 2026 19:29:40 +0800 (CST)
Received: from [100.102.28.251] (100.102.28.251) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sun, 7 Jun 2026 19:29:40 +0800
Message-ID: <1c8489d6-c55b-426d-b965-b6b96caa616f@huawei.com>
Date: Sun, 7 Jun 2026 19:29:39 +0800
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
Subject: Re: [PATCH] erofs-utils: build: link tools with liberofs dependencies
To: <linux-erofs@lists.ozlabs.org>, <guoxuenan@huawei.com>,
	<zhukeqian1@huawei.com>
References: <20260529071702.981596-1-zhaoyifan28@huawei.com>
 <aiA8AhQvFtK_QMwb@debian>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <aiA8AhQvFtK_QMwb@debian>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.102.28.251]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3521-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	HAS_XOIP(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,huawei.com:mid,huawei.com:dkim,huawei.com:from_mime,huawei.com:email,configure.ac:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77887650733


On 2026/6/3 22:36, Gao Xiang wrote:
> Hi Yifan,
>
> On Fri, May 29, 2026 at 03:17:02PM +0800, Yifan Zhao wrote:
>> liberofs.la is a noinst libtool archive, so relying on its
>> dependency_libs to carry external libraries is not enough for
>> static-only dependencies.
>>
>> For example, when liblzma is installed as a static libtool archive,
>> libtool consumes -llzma while creating liberofs.la but does not record it
>> in dependency_libs.  The final tools then link only with liberofs.la and
>> fail with undefined lzma_* references.
>>
>> Collect liberofs external libraries in LIBEROFS_LIBS and use it for both
>> liberofs.la and the final tools, so final executable links see the
>> pkg-config supplied liblzma flags directly.
>>
>> Reported-by: Guo Xuenan <guoxuenan@huawei.com>
>> Fixes: 6c2a000782b2 ("erofs-utils: lib: add test for s3erofs_prepare_url()")
>> Assisted-by: Codex:GPT-5.5
>> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
>> ---
>> To reproduce link error:
>>
>>      ./autogen.sh
>>      PKG_CONFIG_PATH=/path/to/xz-static/lib/pkgconfig ./configure
>>      make -j
>>
>> Then {mkfs,dump,fsck}.erofs reports missing lzma_* symbol as `-llzma`
>> missing in ld flags.
>>
>>   configure.ac      | 17 +++++++++++++++++
>>   dump/Makefile.am  |  2 +-
>>   fsck/Makefile.am  |  4 ++--
>>   fuse/Makefile.am  |  5 +++--
>>   lib/Makefile.am   | 14 +++-----------
>>   mkfs/Makefile.am  |  2 +-
>>   mount/Makefile.am |  2 +-
>>   7 files changed, 28 insertions(+), 18 deletions(-)
>>
>> diff --git a/configure.ac b/configure.ac
>> index f68bb74..17b4856 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -790,6 +790,23 @@ AM_CONDITIONAL([ENABLE_STATIC_FUSE], [test "x${enable_static_fuse}" = "xyes"])
>>   AM_CONDITIONAL([ENABLE_OCI], [test "x${have_oci}" = "xyes"])
>>   AM_CONDITIONAL([ENABLE_FANOTIFY], [test "x${have_fanotify}" = "xyes"])
>>   
>> +LIBEROFS_LIBS="${libselinux_LIBS} ${libuuid_LIBS} ${liblz4_LIBS} \
>> +${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} ${libzstd_LIBS} \
>> +${libqpl_LIBS} ${libcurl_LIBS} ${openssl_LIBS} ${json_c_LIBS}"
>> +AS_IF([test "x${have_xxhash}" = "xyes"], [
>> +  LIBEROFS_LIBS="${LIBEROFS_LIBS} ${libxxhash_LIBS}"
>> +])
>> +AS_IF([test "x${have_s3}" = "xyes"], [
>> +  LIBEROFS_LIBS="${LIBEROFS_LIBS} ${libxml2_LIBS}"
>> +])
>> +AS_IF([test "x${enable_multithreading}" != "xno"], [
>> +  LIBEROFS_LIBS="${LIBEROFS_LIBS} -lpthread"
>> +])
>> +AS_IF([test "x${build_linux}" = "xyes"], [
>> +  LIBEROFS_LIBS="${LIBEROFS_LIBS} ${libnl3_LIBS}"
>> +])
> Although I admit that I'm not super happy with this approach, but it
> seems that we have to do like this.
>
> My only question here is that why  ${libxxhash_LIBS},  ${libxml2_LIBS}
> and ${libnl3_LIBS} cannot be appended directly to LIBEROFS_LIBS as
> others.

As these flags were conditionally appended to liberofs_la_LDFLAGS in the 
original lib/Makefile.am code path.


Thanks,

Yifan

> But I think it's fine to guard `-lpthread` with enable_multithreading
> tho.
>
> Thanks,
> Gao Xiang
>

