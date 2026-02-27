Return-Path: <linux-erofs+bounces-2441-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGmLI3gSoWlwqAQAu9opvQ
	(envelope-from <linux-erofs+bounces-2441-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Feb 2026 04:41:44 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 822C91B256C
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Feb 2026 04:41:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMYz86Ntxz2xLv;
	Fri, 27 Feb 2026 14:41:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772163700;
	cv=none; b=G00WQN5IKrnFzh1VVcV2gUzqEFJCxayMt9GigfNnKj0Kkedfyy0K9510DEmGQ8KkJRd/ahS49ILMnlPZyDNSAn1GYDLPwBlBb4m0W0xGmacy9wb9N/QPtH+v7sdJXLYipMs+0WN86BHc0mxmkxLBljFqbf+nyBfW5VOeZwA25IHWywj7pCrSAl+Vi1vEsNr1FXIUqUNvX2jn2+VULcd/pjyhBzDDVlLOo5+hFJZ0cP+oICRLNJJGdVmJp9Yasaa00yTZjf/nfw8v+0d4j3/wFGPmRvaFQDMqGlGwM1sVCORPmYgQ/rBUOUDgqrFn06l3hOj81w4tBoCFo7lB2ShLJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772163700; c=relaxed/relaxed;
	bh=MIEGvNRSN8Ft3JD1G/auxIPgpq3JvDOmV7i/jfxfhDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W7O01arcsiUnGvZGpduLgr401P1ExEX/c+MERCsH2lmbRG7+Hm+O88wPuz5UHl0dJ5iTnZEFrNEPjlitHbeS34wLIAcvqqyuqQ4ffDBSTjkRKQx2x5pEyKaG6dqA7QfWwJChmaVkjhp00MBBAaDRp99IQALi0XcguUCiNvp9D/+pYccxCR2/YOzwW7LNRtnWgKzAimOY4QKEaeSaAw0WFo5i8UgEGfjLDC7/yQ4yXuOtWJT6gZdNIs8FFGbF2SE6pZvRvCRFl0zjjlg5kHNTuzFyE8jKnWb3f4dRilIZo6Q0ZQYi7hiK1Emrg5OIoSqgFpXuTmDy8Sfm9VbQlShU/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rheiGjT3; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rheiGjT3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMYz61blRz2xKh
	for <linux-erofs@lists.ozlabs.org>; Fri, 27 Feb 2026 14:41:37 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772163691; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MIEGvNRSN8Ft3JD1G/auxIPgpq3JvDOmV7i/jfxfhDU=;
	b=rheiGjT3mXXSmvlZQzzZoeG/ix9nUqwxPDKC2boJ0FLrWRt3tNENrw9b6N7n9c6vmCPMUv8K4Zzr+EcqDfis2qAdpNYf3mH1t3BtiA70qEyquTxasKkF+6MvbwZKXStSWSb0ltjdNpoW203lkJFxUxYHXAcL2FKfBCI2blPcj/c=
Received: from 30.221.131.231(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wzt0qjS_1772163689 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Feb 2026 11:41:29 +0800
Message-ID: <716c0229-85f1-44a4-aec3-a64ed6360761@linux.alibaba.com>
Date: Fri, 27 Feb 2026 11:41:28 +0800
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
Subject: Re: [PATCH v2] erofs: set fileio bio failed in short read case
To: Sheng Yong <shengyong2026@sina.com>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Sheng Yong <shengyong1@xiaomi.com>, chenguanyou <chenguanyou@xiaomi.com>,
 Yunlei He <heyunlei@xiaomi.com>
References: <20260227023008.147813-1-shengyong2026@sina.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260227023008.147813-1-shengyong2026@sina.com>
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
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:shengyong2026@sina.com,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:shengyong1@xiaomi.com,m:chenguanyou@xiaomi.com,m:heyunlei@xiaomi.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[sina.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-2441-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim,alibaba.com:email,xiaomi.com:email]
X-Rspamd-Queue-Id: 822C91B256C
X-Rspamd-Action: no action

Hi Yong,

On 2026/2/27 10:30, Sheng Yong wrote:
> From: Sheng Yong <shengyong1@xiaomi.com>
> 
> For file-backed mount, IO requests are handled by vfs_iocb_iter_read().
> However, it can be interrupted by SIGKILL, returning the number of
> bytes actually copied. Unused folios in bio are unexpectedly marked
> as uptodate.
> 
>    vfs_read
>      filemap_read
>        filemap_get_pages
>          filemap_readahead
>            erofs_fileio_readahead
>              erofs_fileio_rq_submit
>                vfs_iocb_iter_read
>                  filemap_read
>                    filemap_get_pages  <= detect signal
>                erofs_fileio_ki_complete  <= set all folios uptodate
> 
> This patch addresses this by setting short read bio with an error
> directly.
> 
> Fixes: bc804a8d7e86 ("erofs: handle end of filesystem properly for file-backed mounts")
> Reported-by: chenguanyou <chenguanyou@xiaomi.com>
> Signed-off-by: Yunlei He <heyunlei@xiaomi.com>
> Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>

LGTM, yet I still need more time to run some tests
before upstreaming this in order to miss any corner
cases.

You could run more tests in the same time, thanks!

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

