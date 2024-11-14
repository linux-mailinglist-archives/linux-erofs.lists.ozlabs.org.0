Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE5D9C9615
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Nov 2024 00:27:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XqGWY2Ksxz30WS
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Nov 2024 10:26:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731626807;
	cv=none; b=kFL+MOGlmgq92tU8ghLd4J49GFQmhEMNHXTsTbGDm+Ge9/JXMUkuME4QCSehJoEASrfqAoDFNQojnb8qQvfVhkjpd0I5rKMxLZ0nXOFHL2aM415nopGf7/Ylzy5pAW3DrG/nPESsV6MOlrHaGJkDxxmVQ8LNe4oIklugKYKThj9kikcgRgV2z1S3hBEArtxbzbI6vBMEA9XB3kMVrXDCux7xeVM1lKUkFjKDZy6ba8BABD83735r3kD4EMYfTkSlOo7PbvZn3eRr7n06rGvT+TxQI7ajk/by4IqQy4FA4WkVQeopzdD8Ggy9XuJhv6TIc84KO8kuf0y9Ahx+1/6kjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731626807; c=relaxed/relaxed;
	bh=tnZw5adGdOhJwCinqZvM/nZSomtSMm0guGslbdNkndU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJn2BBBTNQcYflC8yBB23COeJwQCNbQJynHOOOa8DB/NYHwpHn15NDzfgNdJeGi7BQeWadiQlbt0iZYkgnopQaRJ5XXQdESOGZmFrwksuH/RXKOuFS7iGyizl+0txUVLSTV2lmSEvBCOdtgflIF0qyRICquAZQwRcW+c5lBvtdwGanisyZGUM2Ud88P3DcOKO18AmXDKowyomF4+gN0h4Nal+a6BEfsp0T9CQSuD3fVxl4m1jIjjWpxkBMAeSvtyd4VESHvubl2oWz5mZ7R6ITZkwx3G3y2pBq1Drx9hisNdRm2wA0iScU69x02TO8ev0a8Iyb3skegpT9QwuBCc4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tf1YpfcN; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tf1YpfcN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XqGWS5cr3z2yGN
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Nov 2024 10:26:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731626794; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tnZw5adGdOhJwCinqZvM/nZSomtSMm0guGslbdNkndU=;
	b=tf1YpfcNOezfwpnQ8HNhtWfidvqcqlSTa0AF3mJSdStyPBPCVRldrib/9GoETEAv1yp9YTlnSRKb/zxZPISfSE0qR3h08zt7Z0Fp6oMTwG3UilRUYKybHEhDXHHrkpsjvHQZurFqg1hrHbBPTc+6vvIVY7JABxZEEZ9MDdWw5q4=
Received: from 172.20.10.8(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJQNHih_1731626792 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 Nov 2024 07:26:33 +0800
Message-ID: <e878e14a-eec7-4df4-b33d-f2defa8a92cb@linux.alibaba.com>
Date: Fri, 15 Nov 2024 07:26:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: fix file-backed mounts over FUSE
To: Al Viro <viro@zeniv.linux.org.uk>
References: <20241114090109.757690-1-hsiangkao@linux.alibaba.com>
 <20241114161823.GN3387508@ZenIV>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241114161823.GN3387508@ZenIV>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/11/15 00:18, Al Viro wrote:
> On Thu, Nov 14, 2024 at 05:01:09PM +0800, Gao Xiang wrote:
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -38,7 +38,9 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
>>   	}
>>   	if (!folio || !folio_contains(folio, index)) {
>>   		erofs_put_metabuf(buf);
>> -		folio = read_mapping_folio(buf->mapping, index, NULL);
>> +		folio = buf->file ? read_mapping_folio(buf->file->f_mapping,
>> +					index, buf->file) :
>> +			read_mapping_folio(buf->mapping, index, NULL);
>>   		if (IS_ERR(folio))
>>   			return folio;
>>   	}
>> @@ -61,8 +63,8 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
>>   {
>>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>>   
>> -	if (erofs_is_fileio_mode(sbi))
>> -		buf->mapping = file_inode(sbi->fdev)->i_mapping;
>> +	if (erofs_is_fileio_mode(sbi))	/* some fs like FUSE needs it */
>> +		buf->file = sbi->fdev;
> 
> Would be easier to set *both* ->mapping and ->file at that point, so that
> erofs_bread() would just have read_mapping_folio(buf->mapping, index, buf->file),
> unconditionally...

Ok, will do the next version.

Thanks,
Gao Xiang
