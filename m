Return-Path: <linux-erofs+bounces-1675-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06216CF07BF
	for <lists+linux-erofs@lfdr.de>; Sun, 04 Jan 2026 02:43:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dkKvT4X3Jz2yGq;
	Sun, 04 Jan 2026 12:43:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767490997;
	cv=none; b=oA5LADePhdgh588CCl4pAiXJBm7TSQDSBqF71PIex1mzMRJxCDliSkAp8EuMLVKRYiDcJzTcLn/cfEkSeMnwqPQSwR6Eh7SAIr1BTT2QKuK/EgkZ6gC1aYJcC0u4ZdoqXI2XpsEkKVHxq3g+lobZNAt/z63BYKu2cnl92bImR9s7H6hl73lGZCXZgG1pcTy06ZPyLk/RyZAtoNeDlV4riFuM+pCbQc1ljVJSZGr6E1OOyBeEdMS78NNT53aliAkigQMyh2DlSYYSFuQIew5vsovSSrYvQaKQA30kOofcVgVvk38LiX/gxCNh5X7WveyLdbK8atRnTxKf3Xbru8FNlg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767490997; c=relaxed/relaxed;
	bh=KRrhCIpxz1LDS6ir6whVP5aoYcpmmAZbmnN802FOvQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WtcrVFLasfp+aJZeSlIYwvuC1wxNvwhgsZz0Dal8aUatYTBM7uMfgjk4QVgrvZ4mNAtVNFfqkbQU3xYZ0Faqdm6Qbrrp3UgkVb0CfBu3U7ML1xCLnjKpcuFg1/cxErZKGYqASvvqaTJF+gHR097mkFKM21lGl+/EJtH14dQSB0DjUpJ1KwDTkzmxaJkzqDxm5eNNPFQVCctU6l55XazlwQvI4vtdd5q7e7pHbyCFD38E1KBVgSeWkbtXfei5U/h1jpgJeKmu7zmIqZyDfncvGJMS21moFu3U4ZjFDrM0i19qvY2AdwALLaeSbYG7Tt3KNsMqnoFShWWogJLHCrtOuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eGtwnJPE; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eGtwnJPE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dkKvQ5172z2yFh
	for <linux-erofs@lists.ozlabs.org>; Sun, 04 Jan 2026 12:43:12 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767490987; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KRrhCIpxz1LDS6ir6whVP5aoYcpmmAZbmnN802FOvQY=;
	b=eGtwnJPElrMWSfhMuBW0jn+Qt1Qw/4kNUUzFQsFUGn/r3ixXwbzGQW2QiNQ3AaO1y6RjHoE5pCJIsu9LN0ytNAQs3AuB2mkkQq+hrBIj0B5fFZLJnwqwwcaZFT/HR0IhRAe1D0Z3mT3nq1lxAL7aTHhqCx0Yz3dJwHraozlde80=
Received: from 30.221.131.151(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Ww9lsr-_1767490984 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 04 Jan 2026 09:43:04 +0800
Message-ID: <fea2e98b-c852-4708-b619-9f35e00805c0@linux.alibaba.com>
Date: Sun, 4 Jan 2026 09:43:03 +0800
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
Subject: Re: [PATCH 2/2] erofs-utils: Enable 64-bit off_t with
 AC_SYS_LARGEFILE
To: James Le Cuirot <chewi@gentoo.org>, Gao Xiang <xiang@kernel.org>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
References: <20260102153830.150891-2-chewi@gentoo.org>
 <20260102153830.150891-3-chewi@gentoo.org>
 <rlp54h7fqffgfms2hgabxyjdbzmqx6xdhmj7gb2tarro32gj5p@nwb3nqv7jafq>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <rlp54h7fqffgfms2hgabxyjdbzmqx6xdhmj7gb2tarro32gj5p@nwb3nqv7jafq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Jame,

On 2026/1/3 01:07, James Le Cuirot wrote:
> On Fri, Jan 02, 2026 at 03:38:31PM +0000, James Le Cuirot wrote:
>> I was initially just going go fix the += Bashism, but this is the safe
>> and portable way to enable 64-bit off_t. It is not possible to enable it
>> on some very old systems. erofs_off_t is hardcoded to u64, but I believe
>> this will still work correctly alongside a 32-bit off_t.
>>
>> Either way, you don't need HAVE_PREAD64 or HAVE_PWRITE64 because
>> pread64/pwrite64 are aliases of pread/pwrite when off_t is 64-bit. See
>> unistd.h and man pread(2).
>>
>> Signed-off-by: James Le Cuirot <chewi@gentoo.org>
>> ---
>>   configure.ac |  4 +---
>>   lib/io.c     | 20 +-------------------
>>   2 files changed, 2 insertions(+), 22 deletions(-)
>>
>> diff --git a/configure.ac b/configure.ac
>> index 4d34e1f..14332ed 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -251,8 +251,6 @@ AC_CHECK_FUNCS(m4_flatten([
>>   	lsetxattr
>>   	memset
>>   	realpath
>> -	pread64
>> -	pwrite64
>>   	pwritev
>>   	posix_fadvise
>>   	fstatfs
>> @@ -554,7 +552,7 @@ AS_IF([test "x$with_xxhash" != "xno"], [
>>   ])
>>   
>>   # Enable 64-bit off_t
>> -CFLAGS+=" -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64"
>> +AC_SYS_LARGEFILE
>>   
>>   # Configure fuzzing mode
>>   AS_IF([test "x$enable_fuzzing" != "xyes"], [], [
>> diff --git a/lib/io.c b/lib/io.c
>> index aa043ca..eaa5fa7 100644
>> --- a/lib/io.c
>> +++ b/lib/io.c
>> @@ -74,11 +74,7 @@ ssize_t erofs_io_pwrite(struct erofs_vfile *vf, const void *buf,
>>   
>>   	pos += vf->offset;
>>   	do {
>> -#ifdef HAVE_PWRITE64
>> -		ret = pwrite64(vf->fd, buf, len, (off64_t)pos);
>> -#else
>>   		ret = pwrite(vf->fd, buf, len, (off_t)pos);
>> -#endif
>>   		if (ret <= 0) {
>>   			if (!ret)
>>   				break;
>> @@ -208,11 +204,7 @@ ssize_t erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 pos, size_t len)
>>   
>>   	pos += vf->offset;
>>   	do {
>> -#ifdef HAVE_PREAD64
>> -		ret = pread64(vf->fd, buf, len, (off64_t)pos);
>> -#else
>>   		ret = pread(vf->fd, buf, len, (off_t)pos);
>> -#endif
>>   		if (ret <= 0) {
>>   			if (!ret)
>>   				break;
>> @@ -436,11 +428,7 @@ static ssize_t __erofs_copy_file_range(int fd_in, u64 *off_in,
>>   		char *end, *p;
>>   
>>   		to_read = min_t(size_t, length, sizeof(buf));
>> -#ifdef HAVE_PREAD64
>> -		read_count = pread64(fd_in, buf, to_read, *off_in);
>> -#else
>>   		read_count = pread(fd_in, buf, to_read, *off_in);
>> -#endif
>>   		if (read_count == 0)
>>   			/* End of file reached prematurely. */
>>   			return copied;
>> @@ -455,13 +443,7 @@ static ssize_t __erofs_copy_file_range(int fd_in, u64 *off_in,
>>   		/* Write the buffer part which was read to the destination. */
>>   		end = buf + read_count;
>>   		for (p = buf; p < end; ) {
>> -			ssize_t write_count;
>> -
>> -#ifdef HAVE_PWRITE64
>> -			write_count = pwrite64(fd_out, p, end - p, *off_out);
>> -#else
>> -			write_count = pwrite(fd_out, p, end - p, *off_out);
>> -#endif
>> +			ssize_t write_count = pwrite(fd_out, p, end - p, *off_out);
>>   			if (write_count < 0) {
>>   				/*
>>   				 * Adjust the input read position to match what
>> -- 
>> 2.51.2
>>
> 
> Unfortunately, it's been pointed out to me that this change isn't safe because
> the config.h generated by configure is not consistently included everywhere.
> That could be fixed, but I don't feel like untangling that myself.

Sorry for late response.

Yes, currently config.h is not used everywhere, so it's still
perferred to use CFLAGS for now.

Thanks,
Gao Xiang



