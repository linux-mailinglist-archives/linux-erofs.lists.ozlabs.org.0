Return-Path: <linux-erofs+bounces-2484-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH8SDe2TpmnxRAAAu9opvQ
	(envelope-from <linux-erofs+bounces-2484-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 03 Mar 2026 08:55:25 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0136D1EA6CC
	for <lists+linux-erofs@lfdr.de>; Tue, 03 Mar 2026 08:55:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQ7Pv6Y6Vz2yFY;
	Tue, 03 Mar 2026 18:55:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772524515;
	cv=none; b=ExkrBIM0n7q/lstAjcnxuwj+RVdPXZYBGQHgGGBmK3RlHN1B2fwGs4TseNFHCt2AGeR8gnB2dKxy0WJwNOCv+QRYq3JQ8jnJYucg/4PAacQXBfUlCfQCyNckZa23q0UEaaC3tnEjS9LXFJF5pu91L0LL0tGlZu/Cszd9/WwQkynO7Spxm/yXEtZxQ6Sq03T9FKrt0WNn3zgPra4gd4TeCerSTaaUsN3YzF19np22vwHLEcpaoKjM1cH4uIdHkXT1NrIDV5a/6iAcip431sd2xw7wtN4/cz1sdPEr8CgjyqftXWys7WL4g6KrLgWxH1XJN36izX846n1V5GHI7mRWGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772524515; c=relaxed/relaxed;
	bh=bcq/+Er+XlH36TbkDwSj6qIapveA/UvS9c0MTwjC4oE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N84gbi/0pR0eoo3mJf5+jbFRlTJfArFPCFmvFREgS2yow9Sy0kO0Dx+vcG90SDiHdKJAPpZSjD6q2MzSLcvIFVST4DNXjsrBo043JFwXdhVmabYqGqeMrfUiNQGYqD/EgUL2QW9UI3mu6K8+X+u8c3jXKssr0hgpHmTqwYgFrUPlJuHaciY64xaptU+87xV0A0Q2pqrklsSZ3nN5j9KSP+vUu943+RPZsA+ep/eHGB5Be5tkHvrb9C3VUtUvjIhQ1BSrz+nfIfXNMrizQz/2XOX3Nqhm0KGmZfMOS0kC4Pt38q3I9DD79NbBr2fYr/KrA3U9z74QT/80W3V/KrMQsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QYaciU2o; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QYaciU2o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQ7Pt4YQVz2xpk
	for <linux-erofs@lists.ozlabs.org>; Tue, 03 Mar 2026 18:55:14 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 56B3E41A87;
	Tue,  3 Mar 2026 07:55:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B639C116C6;
	Tue,  3 Mar 2026 07:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772524512;
	bh=/gWb85WOvGqAlgOSzLtDehw7AKRnh+7E8B4cTlui6fw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=QYaciU2oTpG8jfg3ywavoUiUqpdz43zwccKQdfL94+zd4UUvD5f9kqIpXU8XSUhTy
	 m1lXpQAXTS6rc+B68mSIoOzBoEvJGtdwQ+GFPa4qerpaiH1ShUUfbRCldUEvc8R0lw
	 JezPOvqEDXFybMiPFQrwGVkebHvCjtQjVKTi3El6atbY8lCukdubtq1j5kPpAQwDlq
	 /iuH2jz5X1T1lyrcvFtTYPT7LqP4+DG/C5jjbDV4foBq1frQsZ/dnza18RsSdA0iQB
	 onYYPhY5BD50yYjm49zykM6l3DKbKX3ZxAi7NPxvPc1mmdTulkNcuD+Tn779xw0JfR
	 O//pf4NTsUnVA==
Message-ID: <59f168be-36ee-4982-b1fe-727e88484b59@kernel.org>
Date: Tue, 3 Mar 2026 15:55:03 +0800
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
Cc: chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Sheng Yong <shengyong1@xiaomi.com>,
 chenguanyou <chenguanyou@xiaomi.com>, Yunlei He <heyunlei@xiaomi.com>
Subject: Re: [PATCH v2] erofs: set fileio bio failed in short read case
To: Sheng Yong <shengyong2026@sina.com>, xiang@kernel.org
References: <20260227023008.147813-1-shengyong2026@sina.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260227023008.147813-1-shengyong2026@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 0136D1EA6CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-2484-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[sina.com,kernel.org];
	FORGED_SENDER(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:chao@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:shengyong1@xiaomi.com,m:chenguanyou@xiaomi.com,m:heyunlei@xiaomi.com,m:shengyong2026@sina.com,m:xiang@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action

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

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

