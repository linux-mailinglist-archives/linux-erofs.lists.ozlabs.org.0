Return-Path: <linux-erofs+bounces-2408-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHzTL7GwnmlxWwQAu9opvQ
	(envelope-from <linux-erofs+bounces-2408-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Feb 2026 09:20:01 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ED01941A9
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Feb 2026 09:20:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLSFB1pBzz3cZY;
	Wed, 25 Feb 2026 19:19:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772007598;
	cv=none; b=IUgeQURkChcuI+r8mOj1REznKWXJP27rMlHn5yKXYWrsGq/i/x+3A5y2s2dxgo2/qf4XeAHknpjJSo2EglFNITPK9rAZvJ214gOQIOKDuT2Ht76dRydJxQRsBIAbDzqS7EI0vy5q4uazdhJtDK0ZQetJUDP3YiyKe2g+ydkBHyOF1XfgxDOSkPUjl5eTYFoESbr5RksW2+R9gvdbhCqzRTde9A3bRc2tGVdQEXHI37i/R/xqRQ7uZn6wZpWDV+4C+Mdu0efe42oi53jt6eDTnagbnCCk8TOHWttqXEem0kWhr+fukXXANV0KiEiZv8flwCoaNxG9TcWwUZs9ejSmww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772007598; c=relaxed/relaxed;
	bh=wLIqgOsBhhyWxC07zREvgEoSjgkNs79mFb9xLz4ZGHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h31mpLMCkybSdkJ4SSbjlMh/JZqa9r7CfkJY4m6eheY+HiGcF2U0IT8i6D7z5bEGEYTDh23r+IzAldYoytQRme2moflXKGWDTRu5Cvs/9W4OWmstTHWm1PY5TOyD4hOaY8XB7JFz96hb0peRrY4l0wO7HEBlMLSni6lErhcJE51tWtfmUOMBKB2E+FfF/tIn4nta0X3hFUmB/Qwd2f+mdyVWUJLvquLlwXoH/dZQXZjdPbUEmNfFJqs+D19JRBqBJExwbHOAQ4HkPD9rrjvrFtuhdSCht/YfCYCzHaCJIKAXzZZi8pgWp0r5WUi07T315pVQUxWlU0rCNJhpLT1bXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OY/vjgyJ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OY/vjgyJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLSF75gQrz3cVZ
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Feb 2026 19:19:55 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772007588; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wLIqgOsBhhyWxC07zREvgEoSjgkNs79mFb9xLz4ZGHs=;
	b=OY/vjgyJzba/C+ocTcYPAEqj9GIsB4brJzWsIJfCdgB8WTi90I4b2FpbjmbDDME3hLb6joNHn2SndBFkvzZZ0Y+aMyicd+tyfwxg7s8vT4JK723qtLgn+fQq1dWapBxk7GofivPevHDkjGj30V9Sy4ZMXxE+06aR6EREc6ITElg=
Received: from 30.221.131.204(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WzlvlQ0_1772007586 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Feb 2026 16:19:47 +0800
Message-ID: <08aa23dd-a70c-46ed-990b-65ef73ea632e@linux.alibaba.com>
Date: Wed, 25 Feb 2026 16:19:46 +0800
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
Subject: Re: [PATCH v4] erofs-utils: lib: fix 48bit addressing detection for
 chunk-based format
To: puneeth_aditya_5656 <myakampuneeth@gmail.com>,
 linux-erofs@lists.ozlabs.org
References: <20260224055712.14110-1-myakampuneeth@gmail.com>
 <20260225073943.11361-1-myakampuneeth@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260225073943.11361-1-myakampuneeth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:myakampuneeth@gmail.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2408-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: C9ED01941A9
X-Rspamd-Action: no action



On 2026/2/25 15:39, puneeth_aditya_5656 wrote:
> The 48-bit chunk format flag was being set inside
> erofs_blob_write_chunked_file right after erofs_blob_getchunk returns.
> At that point chunk->blkaddr is the chunk's offset in the temporary
> blob buffer, not the final image address. The real address is only
> known after erofs_mkfs_dump_blobs applies remapped_base, so a chunk
> that lands above UINT32_MAX after remapping may not get flagged at all,
> producing a corrupt image.
> 
> Fix this by introducing erofs_inode_fixup_chunkformat() which walks
> the chunk array after remapped_base is finalized and sets the 48-bit
> flag if any chunk address exceeds UINT32_MAX. The fixup is called from
> erofs_iflush so that the correct chunkformat is written into the
> on-disk inode header. Both blob chunks (remapped_base + chunk->blkaddr)
> and device chunks (chunk->blkaddr directly) are handled.
> 
> Signed-off-by: Puneeth Aditya <myakampuneeth@gmail.com>

LGTM, will apply, although I still wonder how to add a reasonable
testcase since it needs to generate a huge image.)

Thanks,
Gao Xiang

