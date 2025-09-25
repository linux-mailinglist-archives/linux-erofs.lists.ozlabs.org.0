Return-Path: <linux-erofs+bounces-1099-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCF8B9F07A
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Sep 2025 13:55:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cXXGj5xvVz2yrm;
	Thu, 25 Sep 2025 21:55:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758801341;
	cv=none; b=joluh2J9+mwVcfyw75lTIh4Ev8BJolKGVJgvod/rF1EKsJAry4I+oEDfutOMztg9yRCda40lwPTH7ZdYpe5zy92XA1gtnYeSaSO4UzGZ0+WSkpSHUfQqQF9IG4BbZQbpCCqtwreT8HXtUHOYTIEL0QuE9i499Qy0VRmzqxILER/64y5AQECUymmC/wbrlMlsxCHSCq05GGy64PTipX37qLWJKOG1P5qrkK3CafK3oeygJk/4kedZhhj/XEMjnUCr4CtfxWwX10tCFAp+lhlM3zt7SYw5CE0Lcl+2K7lZ/fFKD8Rxxi9Q74LqGtCuwK5sZibQfLAcDasQNbr5/D+Ijg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758801341; c=relaxed/relaxed;
	bh=SCbRU8MveS1pgXPDEzPy2kt340UB03o/vXxtaoaDWAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ij0sm+hsh3dlEO3/u5P9kLntawgcjZzAMYpSZkPxwdFI2mGpK9KRuH8xS33o01NbqgdtWyLtQiqSl1/zqqOXO2CjoWOS9dotAcWcQ1CYdXe+gp/wrJbokmXxb599muX6V0VSrDdgWlb+pgLuJ7/XTqthbxSa0Cs+2D+m2iczn5Hfq8EJR6chs25qXJuG5+D+2kRFmfDcHOVEUfYNE+7fnpD5VSDfxTcMIvc/eHUX6hCDko9TvOxRb4JU4Hj74f0uf5CNEAZDEzm2Qq/+CZanVbxLKE0cC66Lkl3WFPkw8LK+LDN9pPa2jbuS13lMLaUmeD9FDwqjh0lg9aiIoupe5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QxlcBM3u; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QxlcBM3u; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QxlcBM3u;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QxlcBM3u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cXXGh2kKWz2yqR
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Sep 2025 21:55:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758801335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SCbRU8MveS1pgXPDEzPy2kt340UB03o/vXxtaoaDWAc=;
	b=QxlcBM3uDBD7tngIeN6vpLxjbpoHK1UDgIqlM2/QVab+xTj/qCICi+/qCMBP0TJJQ7IHlp
	o2SAPY/lHuJMjUi6MeCTtUl0hsLvzFl3paSpgZWkaIT4dyDxRP2aHdSfy6G4GoEC70CHGY
	K/MUHDGo7IFdHdEVVSTpYNa4djnjkDQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758801335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SCbRU8MveS1pgXPDEzPy2kt340UB03o/vXxtaoaDWAc=;
	b=QxlcBM3uDBD7tngIeN6vpLxjbpoHK1UDgIqlM2/QVab+xTj/qCICi+/qCMBP0TJJQ7IHlp
	o2SAPY/lHuJMjUi6MeCTtUl0hsLvzFl3paSpgZWkaIT4dyDxRP2aHdSfy6G4GoEC70CHGY
	K/MUHDGo7IFdHdEVVSTpYNa4djnjkDQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-bbdIs0JHOuyy9kWQEDk0Wg-1; Thu, 25 Sep 2025 07:55:32 -0400
X-MC-Unique: bbdIs0JHOuyy9kWQEDk0Wg-1
X-Mimecast-MFC-AGG-ID: bbdIs0JHOuyy9kWQEDk0Wg_1758801331
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45cb604427fso5133755e9.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 25 Sep 2025 04:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758801331; x=1759406131;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCbRU8MveS1pgXPDEzPy2kt340UB03o/vXxtaoaDWAc=;
        b=pnjSUaVoJWtoArvmigYp7abMyu3tS/51oKzfVBtSzC2PUbmdykMZWQcFm7t+0EOv9F
         naBOLTjcfcsUNdEYxi1YwPC9mQq/QEJ8qS05edRKQrxe/YAeHk5ucgZtrOAAKHMetaxi
         2sE42xycV7PABreDCZ8EbrF2pC8dKDwuVLQFQM9Ocf+mJVts/og4VnmWOmw8h1cALFeO
         P6sk1Rs6ChSYEgFTzEr+yzSt2kGASA3pq5JKkN0zQ5Yz12t2LKR4bl/9W85omvjfxS2k
         cupGW8CcgqXIjr0aTbjguhKFk2IRQJsXM9Vgn0SRi7LXFo/nVqTwJk2Q/p/gijqSr8mc
         NiSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIr9Gj7yRtZG6og0FmP9O10YWgtkVRpzQa6m9sgc9YPJo2XYEM1occUgw4yf9jljOWJiN8BbDR35yPhw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwqGCkKcZSYgl6VAlFajNWNLy6CQLuMC+RF886o5wL7apWatcmc
	df7ewKvvGcVEEm1OJnlqqkqn4Z1QhbGCDo2kRqcFWAc77OCbuLl9WbACWmzlv0ojg+yYJEgTHNI
	tLql+bFwfQcwEKH+HFnh7o16WmzE+5o0uAxI50Eu81Oi8qv39ZBPmn7ALulqmgO3ZEw==
X-Gm-Gg: ASbGncvHN2WKwdmo5u6DpYgjnM3z294GPZFHcDE4cbIq3q7Y7/kawjejgY6mgZ6SqRC
	Y/TECmjPYr8cfJ87s9iRhhShPQs76lS6AzY+kiaPuEYK55eGyJ24QeVqqQdDblEnxBqvgKtn3Df
	i5SnJwaGI3a4lF3yNB39mP7au2fyl3I73CLysA7QuHaP6fo7hPAIuZe7d+s8bRaoZwFCqqoavXF
	i5N16ewVeeJAVUwVe458Y/jEtChOvemw47NcoUVmdzxYF2hvM4mwqUL71PFsSHS1AsIaq5HZ7Ud
	UDPMrFszBp1Lit/bQpbVSl0xUiFxkHqq/j+IlH7/t5q8gJa+hVq22fQbcvelWtwTO6tiQuTpXj8
	pN9Gy95YYv5p0VvLC2Rfj6iJjT5zTDaD6ca+5j/pPMp+avQ2pxc/3/93Bm6c8wEn6zHC3
X-Received: by 2002:a05:600c:c83:b0:46e:1c2d:bc84 with SMTP id 5b1f17b1804b1-46e329eb10emr33699005e9.17.1758801330628;
        Thu, 25 Sep 2025 04:55:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt88AWAVfrsW7XtYeqx9eAlzDx2ZLFWRXrQuLhkskEblyKaQxcWglP3fS9EKwD9xW0YpDiXg==
X-Received: by 2002:a05:600c:c83:b0:46e:1c2d:bc84 with SMTP id 5b1f17b1804b1-46e329eb10emr33698205e9.17.1758801329980;
        Thu, 25 Sep 2025 04:55:29 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08? (p200300d82f3ff800c1015c9f3bc93d08.dip0.t-ipconnect.de. [2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33b562d8sm31593705e9.0.2025.09.25.04.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 04:55:29 -0700 (PDT)
Message-ID: <b67dd7cd-2c1c-4566-badf-32082d8cd952@redhat.com>
Date: Thu, 25 Sep 2025 13:55:26 +0200
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
To: "Garg, Shivank" <shivankg@amd.com>,
 Sean Christopherson <seanjc@google.com>,
 Ackerley Tng <ackerleytng@google.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, pbonzini@redhat.com,
 shuah@kernel.org, vbabka@suse.cz, brauner@kernel.org,
 viro@zeniv.linux.org.uk, dsterba@suse.com, xiang@kernel.org,
 chao@kernel.org, jaegeuk@kernel.org, clm@fb.com, josef@toxicpanda.com,
 kent.overstreet@linux.dev, zbestahu@gmail.com, jefflexu@linux.alibaba.com,
 dhavale@google.com, lihongbo22@huawei.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, ziy@nvidia.com, matthew.brost@intel.com,
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
 <aNSt9QT8dmpDK1eE@google.com> <dc6eb85f-87b6-43a1-b1f7-4727c0b834cc@amd.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <dc6eb85f-87b6-43a1-b1f7-4727c0b834cc@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lzNqNbtzvoCH242vvVjsTLgIKhWmNGgn0VUCaeYhQcU_1758801331
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 25.09.25 13:44, Garg, Shivank wrote:
> 
> 
> On 9/25/2025 8:20 AM, Sean Christopherson wrote:
>> My apologies for the super late feedback.  None of this is critical (mechanical
>> things that can be cleaned up after the fact), so if there's any urgency to
>> getting this series into 6.18, just ignore it.
>>
>> On Wed, Aug 27, 2025, Ackerley Tng wrote:
>>> Shivank Garg <shivankg@amd.com> writes:
>>> @@ -463,11 +502,70 @@ bool __weak kvm_arch_supports_gmem_mmap(struct kvm *kvm)
>>>   	return true;
>>>   }
>>>
>>> +static struct inode *kvm_gmem_inode_create(const char *name, loff_t size,
>>> +					   u64 flags)
>>> +{
>>> +	struct inode *inode;
>>> +
>>> +	inode = anon_inode_make_secure_inode(kvm_gmem_mnt->mnt_sb, name, NULL);
>>> +	if (IS_ERR(inode))
>>> +		return inode;
>>> +
>>> +	inode->i_private = (void *)(unsigned long)flags;
>>> +	inode->i_op = &kvm_gmem_iops;
>>> +	inode->i_mapping->a_ops = &kvm_gmem_aops;
>>> +	inode->i_mode |= S_IFREG;
>>> +	inode->i_size = size;
>>> +	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
>>> +	mapping_set_inaccessible(inode->i_mapping);
>>> +	/* Unmovable mappings are supposed to be marked unevictable as well. */
>>> +	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
>>> +
>>> +	return inode;
>>> +}
>>> +
>>> +static struct file *kvm_gmem_inode_create_getfile(void *priv, loff_t size,
>>> +						  u64 flags)
>>> +{
>>> +	static const char *name = "[kvm-gmem]";
>>> +	struct inode *inode;
>>> +	struct file *file;
>>> +	int err;
>>> +
>>> +	err = -ENOENT;
>>> +	/* __fput() will take care of fops_put(). */
>>> +	if (!fops_get(&kvm_gmem_fops))
>>> +		goto err;
>>> +
>>> +	inode = kvm_gmem_inode_create(name, size, flags);
>>> +	if (IS_ERR(inode)) {
>>> +		err = PTR_ERR(inode);
>>> +		goto err_fops_put;
>>> +	}
>>> +
>>> +	file = alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR,
>>> +				 &kvm_gmem_fops);
>>> +	if (IS_ERR(file)) {
>>> +		err = PTR_ERR(file);
>>> +		goto err_put_inode;
>>> +	}
>>> +
>>> +	file->f_flags |= O_LARGEFILE;
>>> +	file->private_data = priv;
>>> +
>>> +	return file;
>>> +
>>> +err_put_inode:
>>> +	iput(inode);
>>> +err_fops_put:
>>> +	fops_put(&kvm_gmem_fops);
>>> +err:
>>> +	return ERR_PTR(err);
>>> +}
>>
>> I don't see any reason to add two helpers.  It requires quite a bit more lines
>> of code due to adding more error paths and local variables, and IMO doesn't make
>> the code any easier to read.
>>
>> Passing in "gmem" as @priv is especially ridiculous, as it adds code and
>> obfuscates what file->private_data is set to.
>>
>> I get the sense that the code was written to be a "replacement" for common APIs,
>> but that is nonsensical (no pun intended).
>>
>>>   static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>>>   {
>>> -	const char *anon_name = "[kvm-gmem]";
>>>   	struct kvm_gmem *gmem;
>>> -	struct inode *inode;
>>>   	struct file *file;
>>>   	int fd, err;
>>>
>>> @@ -481,32 +579,16 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>>>   		goto err_fd;
>>>   	}
>>>
>>> -	file = anon_inode_create_getfile(anon_name, &kvm_gmem_fops, gmem,
>>> -					 O_RDWR, NULL);
>>> +	file = kvm_gmem_inode_create_getfile(gmem, size, flags);
>>>   	if (IS_ERR(file)) {
>>>   		err = PTR_ERR(file);
>>>   		goto err_gmem;
>>>   	}
>>>
>>> -	file->f_flags |= O_LARGEFILE;
>>> -
>>> -	inode = file->f_inode;
>>> -	WARN_ON(file->f_mapping != inode->i_mapping);
>>> -
>>> -	inode->i_private = (void *)(unsigned long)flags;
>>> -	inode->i_op = &kvm_gmem_iops;
>>> -	inode->i_mapping->a_ops = &kvm_gmem_aops;
>>> -	inode->i_mode |= S_IFREG;
>>> -	inode->i_size = size;
>>> -	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
>>> -	mapping_set_inaccessible(inode->i_mapping);
>>> -	/* Unmovable mappings are supposed to be marked unevictable as well. */
>>> -	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
>>> -
>>>   	kvm_get_kvm(kvm);
>>>   	gmem->kvm = kvm;
>>>   	xa_init(&gmem->bindings);
>>> -	list_add(&gmem->entry, &inode->i_mapping->i_private_list);
>>> +	list_add(&gmem->entry, &file_inode(file)->i_mapping->i_private_list);
>>
>> I don't understand this change?  Isn't file_inode(file) == inode?
>>
>> Compile tested only, and again not critical, but it's -40 LoC...
>>
>>
> 
> Thanks.
> I did functional testing and it works fine.

I can queue this instead. I guess I can reuse the patch description and 
add Sean as author + add his SOB (if he agrees).

Let me take a look at the patch later in more detail.

-- 
Cheers

David / dhildenb


