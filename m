Return-Path: <linux-erofs+bounces-91-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C50DBA686F2
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Mar 2025 09:35:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZHhpp2fzlz2yf3;
	Wed, 19 Mar 2025 19:34:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742373298;
	cv=none; b=IFOQY0ru+FSfWcXwlDKNv4r+mb1pmEn5aZ/W4Q6z3+3ef+/bGBgD8braSks9sXxNn7ZPUqct7NoHW7F1eKy0yBYKlJTfRZ6oU/TOWMfL3YlVISiQJGMam5RehlTqB8yfb5OyK5xYJSv5NgInukX7g64bfVaWpK/oeR7NkPI7S5Nz9wANB60uy9R7/kmEG4NygOkUmsAs+gumRVFdKrlNNONGmV0NHFYvQf5m7SwGoKvadfr/ygGQop5DLyPubwDHPuvp/XDjOJcpOMUU0zH90yNI/FPXaB4QPRt8NI0O4lJI5++kdc0R+DncUnkn7xr03jacbIsLdOO+4aZYI26QNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742373298; c=relaxed/relaxed;
	bh=RR5YqJVptrlygILdNOhzAjC7cpOvrMCLJY+Szj5Ekn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NGylTHMwPT3sm9dXr9dVTe7NeMFG0rtrP3az0P6nAWdxzWrIoNSijcD/V7hPSLHZEAOPDJVeKTVqQK2EHusEVMBl6O+HMFO8XXofM6cO4tHhmuuXbcnxa8w8+qeRriGVC7NkvgtdRTBOCLJsVgtEDbDwfXCFKK+pSo8cQmix9Q6SamHCmixBAYdzRcmc6iNk3knRIUAP2rC+NyMFSft8afHDJVWtqSVq58C8NX9KBCa9fgbSr8zOQ6Frv30TTvxQqtCtdRDo2kSix/2c2/FCZygyJKrNnwH3vspY3df9ozzus9i/ly/ik1RcED3nZP4AvKaGmovhKjeZp26o/olMzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eWXKRSKJ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eWXKRSKJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZHhpm0BnVz2xQ5
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Mar 2025 19:34:54 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742373290; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RR5YqJVptrlygILdNOhzAjC7cpOvrMCLJY+Szj5Ekn4=;
	b=eWXKRSKJHqzAc+DE0E8/BNtv5TFq/+ykGzpH6I5t442rJMmNtHoY97rjG09LgpUZrK+g3/ZREot3t4E8jFOFqTKIGESjqZD8LfL5731C5fOxm7vY92Pcl3Jid/d8utiQv089ZCYWxZdY/M0RS+ADyZYqIXR4dGvYzCL5yAIcsH4=
Received: from 30.74.128.211(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WS1efwN_1742373287 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Mar 2025 16:34:48 +0800
Message-ID: <d6643b61-1411-4858-b75e-76bcbb75071c@linux.alibaba.com>
Date: Wed, 19 Mar 2025 16:34:47 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] iomap: fix inline data on buffered read
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org,
 Bo Liu <liubo03@inspur.com>, "Darrick J. Wong" <djwong@kernel.org>,
 Brian Foster <bfoster@redhat.com>
References: <20250319025953.3559299-1-hsiangkao@linux.alibaba.com>
 <20250319081730.GB26281@lst.de> <20250319082323.GA26665@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250319082323.GA26665@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Christoph,

On 2025/3/19 16:23, Christoph Hellwig wrote:
> On Wed, Mar 19, 2025 at 09:17:30AM +0100, Christoph Hellwig wrote:
>> I'd move the iomap_iter_advance into iomap_read_inline_data, just like
>> we've pushed it down as far as possible elsewhere, e.g. something like
>> the patch below.  Although with that having size and length puzzles
>> me a bit, so maybe someone more familar with the code could figure
>> out why we need both, how they can be different and either document
>> or eliminate that.
> 
> ... and this doesn't even compile because it breaks write_begin.
> So we'll need to keep it in the caller, but maybe without the
> goto and just do the plain advance on length?

Yeah, I was just writing an email to your previous reply:

I think iomap_write_begin_inline() will break if
iomap_iter_advance() is in iomap_read_inline_data().

Because:
   iomap_write_iter
      iomap_write_begin
        iomap_write_begin_inline
          iomap_read_inline_data
             iomap_iter_advance		# 1
      copy_folio_from_iter_atomic
      iomap_write_end
      ...
      iomap_iter_advance			# 1

I will do a plain advance as your suggested instead, but commit
"iomap: advance the iter directly on buffered read" makes EROFS
unusable, and I think gfs2 too.  It needs be fixed now.

Thanks,
Gao Xiang

Thanks,
Gao Xiang


