Return-Path: <linux-erofs+bounces-934-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E3EB3990D
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Aug 2025 12:06:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cCH9b6Ysbz2xnk;
	Thu, 28 Aug 2025 20:06:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756375587;
	cv=none; b=e2QwYN9+Jn9zNE8aCWmE02DGOeTxZmdDHvNMqFDTOmdAhWMQrKuHIxXs/7XqS9umtp63E71CG2pQBuOaGusDfthf2X+wSAZSoSQlaa2dUv6TRMulXQyM83mJrfORHyQyB2TyGqzFU8Cq1XQ4P5z/GGVIcDWwBc6eoDabeJYRH4s+Cf/WuODC+G7VOTER5a1NG7uUvX2yvvpnTnWcpPyeAzS119S1K6vYI0SbyqBD9ssul/pXtr0MG0W3KMnx6O37pvQDg652wNUtAMEd1UOE/49sDpJ6iKb9sHqomO5maEsTxGMqpeumhu3cMae6lfdOld/seIurlD5xkOSECGD0aA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756375587; c=relaxed/relaxed;
	bh=AIuF++MW+9cppH2LcogxBtVCMHjKY7lH5B9a+qhZ5nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GESDkLilMZOT/s35jo8DX1LP5mzvKzBCHIHKFyTzSb4HA4skw+jX2x7cuSYrBR4DnoVEVYLWMN3V5koQN3dsPjxqzQp6GSaiEAbheITzDfq/m6jg9t9z8uBGKqNPJHEOH8dQc40geKW/2Fzdedy4SECXqsFUXnNpXPIognfeouWziqrYMvlk387TVmcSiEF/u8/mJf7WucB52k0ELHonNLVRCaj88QCbTvfBvX4uEVd7juSJnyquP44JizYv7j4DSNxR7YfIrEbzKzM31yMZ3P4hR5l8dCToOj36Ip3raOsKC0WOmFyi04sw7Se86iEWaXPkHsKMLf5X9Y3JkhhYxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bdu/+Evn; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MNLjZBah; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bdu/+Evn;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MNLjZBah;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cCH9Z5Mcgz2xSd
	for <linux-erofs@lists.ozlabs.org>; Thu, 28 Aug 2025 20:06:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756375580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AIuF++MW+9cppH2LcogxBtVCMHjKY7lH5B9a+qhZ5nk=;
	b=bdu/+EvndH9UhyH0ZtPZs5gvfrDagRlK7thkh+a8MgwcZppz6adUqXtsr+qFWlkLn4jvMU
	EgIidaV4acS53iwtM/B3xPFcDBkU5MLOwg+h7+ghla/2hiMNZlD36tgYRMbIbryjMvFOUQ
	6e8LfP+6H+j7rqCWUMxQ7bYxZc8Fvp4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756375581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AIuF++MW+9cppH2LcogxBtVCMHjKY7lH5B9a+qhZ5nk=;
	b=MNLjZBahy87t2k3g0duIG6YMJSTQK3cpsYNxKTQ1B1OuhXBI2QGlE3byn+9nWFjRGs47VC
	tk6b6HLgsx9Bwz1FdXrvIdYbWgBnHx/EaM6eEQzxJpIApBRrmhZ9ScFa1SCJSWkYBkZybL
	Cm5CZeNWCOHpCZ4ACJtj0Im/KiN6Hhg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-jssUhQHiMZWdKZR0IA7omA-1; Thu, 28 Aug 2025 06:06:18 -0400
X-MC-Unique: jssUhQHiMZWdKZR0IA7omA-1
X-Mimecast-MFC-AGG-ID: jssUhQHiMZWdKZR0IA7omA_1756375577
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3cceb92ea73so463308f8f.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 28 Aug 2025 03:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756375577; x=1756980377;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AIuF++MW+9cppH2LcogxBtVCMHjKY7lH5B9a+qhZ5nk=;
        b=qsuziV9+4o0rLrZvkN6lN+ECZfqt6/fSwxutAdO8fReg7u20n9VG/JI+w+vfGaNi1N
         i5Rthzh/dRdz02dIHXXyyHVsQgI2lg1W4HfecGMtDvjyhnJN5jn0LVe3Zjf1Y0tAquEm
         /nX3Ggc5lnu99jHnv9CC+uLF4WsAFLWbRnfmVC6xynZkZt4g0cMSNHaLAUxVV1v69Z2z
         TWEjvebK01+grvrMsOL4o6tzeBcO/BjelupC91jxg8QqIrcJ0ZjadoSJlODiFRyY3XGG
         nvAvhx51KWsbMHDO+aWZ+mdaZfAGqY5RC4pignOZTbKkCImZ73Jlgc3rjBDuqnzQhtNE
         I02g==
X-Forwarded-Encrypted: i=1; AJvYcCWYLhg0mfPJu3KGur3UXSD23SPKRm+oJvWMWOgyxdzLN/NXUr8TOXThvCkFEhJS+y4MeM3Du3jVaYKfog==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz68TpmLq8mDY1NskjofNRW5Nu8NWI9OaZRFaG0WBN4K70AYi3f
	fBlnmaF0Asv6734cvL8+E9amxSti1u2/YfEfKta/baZaXaoBAmuX+34G99Gkis5XTufADlN87dz
	n5xP6mOZb29YlkwFvKi/GcceqplE9hF8Nc3oB0bu5CV3nIUeQdk2g7LLMX/ILxuOxng==
X-Gm-Gg: ASbGncsQWaf4tinPspM24nD7WdH6C7BQ8yOmfQ5UQKNxdWUtE+gePjmZ/nqYt2why4s
	AjeMbaz1tBcuAESKf7AO8AIU6EQIEDN3Qm7rEmOY/kfXZyDMzqALTySiymJ0Pa+GvlwTjNwSios
	JbwfE34M+tL/efIqX7CpzRNYrZRtRAp5bnwWFLbwV31+cYRbWt5B28YVPbTfau6X2AmwvWG+yQX
	cGfE6P2Q0PIdzvWZFnNros6HpkeRAXrtsz8qilg14cgAbjQx2UI2b5trQR268eacUorFZyr8gR+
	PMSQ85QI8KSSYhnv/5BSu1YH1y6C6qf/RRdtw68l1j/TkDC32mi0/6969k2/p+r46ofWgG2GLT0
	ISOYbTuxX3oAhRzn9aROWozDyBdHV0ny/g8Oy4O9ToeqQHLsMUpQzJ9Vsj/Tphc1bKO8=
X-Received: by 2002:a5d:64e1:0:b0:3b6:436:b8ea with SMTP id ffacd0b85a97d-3c5da83c601mr15705056f8f.6.1756375577282;
        Thu, 28 Aug 2025 03:06:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv6FDhe/e4+uPIRUaF8D2ckX5J+70BvRLKIj3J1sQm8lva6qxwVAKdzmfSmO9HiwptWSyrXw==
X-Received: by 2002:a5d:64e1:0:b0:3b6:436:b8ea with SMTP id ffacd0b85a97d-3c5da83c601mr15705026f8f.6.1756375576743;
        Thu, 28 Aug 2025 03:06:16 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:c100:2225:10aa:f247:7b85? (p200300d82f28c100222510aaf2477b85.dip0.t-ipconnect.de. [2003:d8:2f28:c100:2225:10aa:f247:7b85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4b9f8dsm26199961f8f.9.2025.08.28.03.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 03:06:15 -0700 (PDT)
Message-ID: <4db9239a-efe3-43b2-b7b4-af497eb9ee28@redhat.com>
Date: Thu, 28 Aug 2025 12:06:12 +0200
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
Subject: Re: [PATCH kvm-next V11 4/7] KVM: guest_memfd: Use guest mem inodes
 instead of anonymous inodes
To: Ackerley Tng <ackerleytng@google.com>, Shivank Garg <shivankg@amd.com>,
 willy@infradead.org, akpm@linux-foundation.org, pbonzini@redhat.com,
 shuah@kernel.org, seanjc@google.com, vbabka@suse.cz
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, dsterba@suse.com,
 xiang@kernel.org, chao@kernel.org, jaegeuk@kernel.org, clm@fb.com,
 josef@toxicpanda.com, kent.overstreet@linux.dev, zbestahu@gmail.com,
 jefflexu@linux.alibaba.com, dhavale@google.com, lihongbo22@huawei.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 tabba@google.com, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 pvorel@suse.cz, bfoster@redhat.com, vannapurve@google.com,
 chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com,
 shdhiman@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com, jgg@nvidia.com,
 kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz, hch@infradead.org,
 cgzones@googlemail.com, ira.weiny@intel.com, rientjes@google.com,
 roypat@amazon.co.uk, chao.p.peng@intel.com, amit@infradead.org,
 ddutile@redhat.com, dan.j.williams@intel.com, ashish.kalra@amd.com,
 gshan@redhat.com, jgowans@amazon.com, pankaj.gupta@amd.com,
 papaluri@amd.com, yuzhao@google.com, suzuki.poulose@arm.com,
 quic_eberman@quicinc.com, linux-bcachefs@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev
References: <20250827175247.83322-2-shivankg@amd.com>
 <20250827175247.83322-7-shivankg@amd.com> <diqztt1sbd2v.fsf@google.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <diqztt1sbd2v.fsf@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l6YhFhFjYXn2F_cpHdZtANbmfK5sXD3T6oyyqcHGpSw_1756375577
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 28.08.25 00:43, Ackerley Tng wrote:
> Shivank Garg <shivankg@amd.com> writes:
> 
>>
>> [...snip...]
>>
> 
> I meant to send this to you before this version went out but you were
> too quick!
> 
> Here's a new version, Fuad and I reviewed this again internally. The
> changes are:
> 
> + Sort linux/pseudo_fs.h after linux/pagemap.h (alphabetical)
> + Don't set MNT_NOEXEC on the mount, since SB_I_NOEXEC was already set
>    on the superblock
> + Rename kvm_gmem_inode_make_secure_inode() to kvm_gmem_inode_create()
>      + Emphasizes that there is a creation in this function
>      + Remove "secure" from the function name to remove confusion that
>        there may be a "non-secure" version
> + In kvm_gmem_inode_create_getfile()'s error path, return ERR_PTR(err)
>    directly instead of having a goto
> 
> 
>  From ada9814b216eac129ed44dffd3acf76fce2cc08a Mon Sep 17 00:00:00 2001
> From: Ackerley Tng <ackerleytng@google.com>
> Date: Sun, 13 Jul 2025 17:43:35 +0000
> Subject: [PATCH] KVM: guest_memfd: Use guest mem inodes instead of anonymous
>   inodes
> 
> guest_memfd's inode represents memory the guest_memfd is
> providing. guest_memfd's file represents a struct kvm's view of that
> memory.
> 
> Using a custom inode allows customization of the inode teardown
> process via callbacks. For example, ->evict_inode() allows
> customization of the truncation process on file close, and
> ->destroy_inode() and ->free_inode() allow customization of the inode
> freeing process.
> 
> Customizing the truncation process allows flexibility in management of
> guest_memfd memory and customization of the inode freeing process
> allows proper cleanup of memory metadata stored on the inode.
> 
> Memory metadata is more appropriately stored on the inode (as opposed
> to the file), since the metadata is for the memory and is not unique
> to a specific binding and struct kvm.
> 
> Co-developed-by: Fuad Tabba <tabba@google.com>
> Signed-off-by: Fuad Tabba <tabba@google.com>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


